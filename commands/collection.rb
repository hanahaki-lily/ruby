def register_collection(bot)
  bot.command(:collection) do |event|
    server_id = event.server.id.to_s
    user_id   = event.user.id.to_s

    ensure_user(server_id, user_id)
    user = $data[server_id][user_id]

    user["cards"] ||= {}
    cards_owned = user["cards"]

    if cards_owned.empty?
      event.respond "❌ You don't have any cards yet! Try `!wish` to draw some."
      next
    end

    total_owned  = cards_owned.values.sum
    unique_owned = cards_owned.keys.size

    # Optional: alphabetical display
    description = cards_owned
      .sort_by { |name, _| name }
      .map { |name, count| "#{name}: #{count}" }
      .join("\n")

    event.channel.send_embed do |e|
      e.title = "#{event.user.name}'s Collection"
      e.description = description
      e.footer = Discordrb::Webhooks::EmbedFooter.new(
        text: "Unique cards: #{unique_owned}/#{TOTAL_CARDS} | Total cards: #{total_owned}"
      )
      e.color = 0xFFD700
    end

    nil
  end
end