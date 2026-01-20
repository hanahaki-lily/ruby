require 'discordrb'
require 'json'
require_relative '../config/constants'
require_relative '../utils/data_handler'

class MessageXp
  attr_reader :name

  def initialize
    @name = "message_xp"
    @xp_cooldowns = {}
  end

  def execute(bot)
    bot.message do |event|
      next if event.user.bot_account?
      next unless event.server

      server_id = event.server.id.to_s
      user_id   = event.user.id.to_s
      now       = Time.now.to_i

      @xp_cooldowns[server_id] ||= {}
      @xp_cooldowns[server_id][user_id] ||= 0
      next if now - @xp_cooldowns[server_id][user_id] < XP_COOLDOWN
      @xp_cooldowns[server_id][user_id] = now

      $data ||= {}
      $data[server_id] ||= {}
      $data[server_id][user_id] ||= { "xp" => 0, "level" => 1, "gems" => 0 }
      user_data = $data[server_id][user_id]

      # ---------------- XP + GEMS ----------------
      xp_gain  = rand(5..15)
      gem_gain = rand(1..3)
      user_data["xp"]   += xp_gain
      user_data["gems"] += gem_gain

      # ---------------- LEVELING ----------------
      levels_gained = 0
      loop do
        required_xp = user_data["level"] * 100
        break if user_data["xp"] < required_xp
        user_data["level"] += 1
        levels_gained += 1
      end

      # ---------------- LEVEL UP EVENT ----------------
      if levels_gained > 0
        new_level = user_data["level"]
        reward_gems = levels_gained * GEMS_PER_LEVEL
        user_data["gems"] += reward_gems

        embed = Discordrb::Webhooks::Embed.new(
          title: "🌸 Level Up!",
          description: "#{event.user.mention} reached **Level #{new_level}** ✨\n💎 **+#{reward_gems} Wish Gems**",
          color: EMBED_COLOR
        )
        embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: event.user.avatar_url)
        embed.footer = Discordrb::Webhooks::EmbedFooter.new(
          text: "Moonlight Palace",
          icon_url: event.server.icon_url
        )

        event.channel.send_embed('', embed)

        # ---------------- LEVEL ROLES ----------------
        event.user.roles
          .select { |r| LEVEL_ROLES.values.include?(r.name) }
          .each { |r| event.user.remove_role(r) }

        LEVEL_ROLES.sort.each do |lvl, role_name|
          next if new_level < lvl
          role = event.server.roles.find { |r| r.name == role_name }
          event.user.add_role(role) if role
        end
      end

      # ---------------- SAVE DATA ----------------
      save_data
    end
  end
end
