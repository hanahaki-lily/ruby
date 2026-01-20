def register_level(bot)
  bot.command(:level) do |event, user_mention|
    server_id = event.server.id.to_s

    target =
      if user_mention
        match = user_mention.match(/<@!?(\d+)>/)
        match ? event.server.member(match[1].to_i) : nil
      else
        event.user
      end

    unless target
      event.respond "Please mention a valid user ❤️"
      next
    end

    target_id = target.id.to_s

    ensure_user(server_id, target_id)
    user_data = $data[server_id][target_id]

    # ---------------- RANK CALCULATION ----------------

    ranked = $data[server_id].sort_by do |_, d|
      [-d["level"], -d["xp"]]
    end

    rank_index = ranked.index { |uid, _| uid == target_id }
    rank  = rank_index ? rank_index + 1 : "?"
    crown = rank == 1 ? " 👑" : ""

    xp    = user_data["xp"]
    level = user_data["level"]
    gems  = user_data["gems"]

    # ---------------- XP PROGRESS (CUMULATIVE) ----------------

    current_level_total = (level - 1) * 100
    next_level_total    = level * 100

    display_xp = [xp, current_level_total].max
    progress_xp = display_xp - current_level_total
    needed_xp   = next_level_total - current_level_total

    blocks = 10
    filled = ((progress_xp.to_f / needed_xp) * blocks).floor
    filled = [[filled, 0].max, blocks].min

    bar = "▰" * filled + "▱" * (blocks - filled)

    # ---------------- EMBED ----------------

    embed = Discordrb::Webhooks::Embed.new(
      title: "🌙 #{target.username}'s Level",
      color: EMBED_COLOR
    )

    embed.description = <<~DESC
      🏆 **Server Rank:** ##{rank}#{crown}
      ✨ **Level:** #{level}
      💎 **Wish Gems:** #{gems}

      #{bar}
      #{progress_xp}/#{needed_xp} XP
    DESC

    embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(
      url: target.avatar_url
    )

    embed.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: "Keep chatting to earn XP & Wish Gems",
      icon_url: event.server.icon_url
    )

    event.channel.send_embed('', embed)
    nil
  end
end
