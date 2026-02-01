class Leaderboard
  attr_reader :name, :description

  def initialize
    @name = "leaderboard"
    @description = "Displays the top 10 users in the server based on Level and XP."
  end

  def execute(event)
    server_id = event.server.id.to_s
    
    users = $data[server_id] || {}

    leaderboard_entries = users
      .sort_by { |_, d| [-d["level"].to_i, -d["xp"].to_i] }
      .first(10)
      .map.with_index(1) do |(uid, d), i|
        member = event.server.member(uid.to_i)
        name = member ? member.display_name : "Unknown User"
        "#{i}. **#{name}** — Level: #{d['level']} (XP: #{d['xp']})"
      end
      .join("\n")

    event.respond(embeds: [
      {
        title: "✨ Server Leaderboard",
        description: leaderboard_entries.empty? ? "No data yet!" : leaderboard_entries,
        color: EMBED_COLOR,
        footer: {
          text: "Moonlight Palace Rankings",
          icon_url: event.server.icon_url
        }
      }
    ])
  end
end