def register_leaderboard(bot)
  bot.command(:leaderboard) do |event|
    server_id = event.server.id.to_s
    users = $data[server_id] || {}

    desc = users
      .sort_by { |_, d| [-d["level"], -d["xp"]] }
      .first(10)
      .map.with_index(1) do |(uid, d), i|
        member = event.server.member(uid.to_i)

        name =
          if member
            member.display_name
          else
            "Unknown User"
          end

        "#{i}. **#{name}** — Level: #{d['level']} (XP: #{d['xp']})"
      end
      .join("\n")

    embed = Discordrb::Webhooks::Embed.new(
      title: "✨ Server Leaderboard",
      description: desc.empty? ? "No data yet!" : desc,
      color: EMBED_COLOR
    )

    embed.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: "Moonlight Palace Rankings",
      icon_url: event.server.icon_url
    )

    event.channel.send_embed('', embed)
    nil
  end
end
