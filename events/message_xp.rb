def register_message_xp(bot)
  xp_cooldowns = {}

  bot.message do |event|
    next if event.user.bot_account?
    next unless event.server

    server_id = event.server.id.to_s
    user_id   = event.user.id.to_s
    now       = Time.now.to_i

    # Cooldowns are per-server per-user
    xp_cooldowns[server_id] ||= {}
    xp_cooldowns[server_id][user_id] ||= 0

    next if now - xp_cooldowns[server_id][user_id] < XP_COOLDOWN
    xp_cooldowns[server_id][user_id] = now

    # Ensure data exists
    ensure_user(server_id, user_id)
    user = $data[server_id][user_id]

    # ---------------- XP + GEMS (per message) ----------------

    xp_gain  = rand(5..15)
    gem_gain = rand(1..3)

    user["xp"]   += xp_gain
    user["gems"] += gem_gain

    # ---------------- LEVELING ----------------

    levels_gained = 0

    loop do
      level = user["level"]
      required_xp = level * 100
      break if user["xp"] < required_xp

      user["level"] += 1
      levels_gained += 1
    end

    # ---------------- LEVEL UP EVENT ----------------

    if levels_gained > 0
      new_level = user["level"]
      reward_gems = levels_gained * GEMS_PER_LEVEL

      user["gems"] += reward_gems

      embed = Discordrb::Webhooks::Embed.new(
        title: "🌸 Level Up!",
        description: <<~DESC,
          #{event.user.mention} reached **Level #{new_level}** ✨
          💎 **+#{reward_gems} Wish Gems**
        DESC
        color: EMBED_COLOR
      )

      embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(
        url: event.user.avatar_url
      )

      embed.footer = Discordrb::Webhooks::EmbedFooter.new(
        text: "Moonlight Palace",
        icon_url: event.server.icon_url
      )

      event.channel.send_embed('', embed)

      # Remove old level roles
      event.user.roles
        .select { |r| LEVEL_ROLES.values.include?(r.name) }
        .each { |r| event.user.remove_role(r) }

      # Assign highest valid role
      LEVEL_ROLES.sort.each do |lvl, role_name|
        next if new_level < lvl

        role = event.server.roles.find { |r| r.name == role_name }
        event.user.add_role(role) if role
      end
    end

    save_data($data)
  end
end
