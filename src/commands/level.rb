require 'discordrb'
require 'json'
require_relative '../config/constants'

class Level
  attr_reader :name, :description

  def initialize
    @name = "level"
    @description = "Shows your level, XP, and server rank."
  end

  def execute(event)
    server = event.server
    user   = event.user

    unless server
      event.respond(content: "This command can only be used in a server.", ephemeral: true)
      return
    end

    server_id = server.id.to_s
    user_id   = user.id.to_s

    # ---------------- SAFE DATA INITIALIZATION ----------------
    $data ||= {}
    $data[server_id] ||= {}

    clean_data = {}
    $data[server_id].each do |uid, d|
      next unless d.is_a?(Hash)
      clean_data[uid] = {
        "xp"    => d["xp"].to_i,
        "level" => d["level"].to_i,
        "gems"  => d["gems"].to_i
      }
    end

    clean_data[user_id] ||= { "xp" => 0, "level" => 1, "gems" => 0 }

    # ---------------- RANK CALCULATION ----------------
    ranked = clean_data.sort_by { |_, d| [-d["level"], -d["xp"]] }
    rank_index = ranked.index { |uid, _| uid == user_id }
    rank = rank_index ? rank_index + 1 : "?"
    crown = rank == 1 ? " 👑" : ""

    user_data = clean_data[user_id]
    xp    = user_data["xp"]
    level = user_data["level"]
    gems  = user_data["gems"]

    # ---------------- XP BAR ----------------
    current_level_total = (level - 1) * 100
    next_level_total    = level * 100
    progress_xp = [xp - current_level_total, 0].max
    needed_xp   = next_level_total - current_level_total

    blocks = 10
    filled = ((progress_xp.to_f / needed_xp) * blocks).floor
    filled = [[filled, 0].max, blocks].min
    bar = "▰" * filled + "▱" * (blocks - filled)

    # ---------------- EMBED ----------------
    embed = Discordrb::Webhooks::Embed.new(
      title: "🌙 #{user.username}'s Level",
      color: EMBED_COLOR
    )

    embed.description = <<~DESC
      🏆 **Server Rank:** ##{rank}#{crown}
      ✨ **Level:** #{level}
      💎 **Wish Gems:** #{gems}

      #{bar}
      #{progress_xp}/#{needed_xp} XP
    DESC

    avatar_url = user.avatar_url || user.default_avatar_url
    embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: avatar_url)
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: "Keep chatting to earn XP & Wish Gems",
      icon_url: server.icon_url
    )

    # ---------------- RESPOND ----------------
    event.respond(embeds: [embed.to_hash])
  end
end
