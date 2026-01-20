def register_wish(bot)
  bot.command(:wish) do |event|
    server_id = event.server.id.to_s
    user_id   = event.user.id.to_s

    ensure_user(server_id, user_id)
    user = $data[server_id][user_id]

    user["cards"] ||= {}

    if user["gems"] < CARD_COST
      event.respond "❌ You need #{CARD_COST} gems to wish!"
      next
    end

    user["gems"] -= CARD_COST

    card = AMIIBO_CARDS.sample
    user["cards"][card[:name]] ||= 0
    user["cards"][card[:name]] += 1

    save_data($data)

    event.channel.send_embed do |e|
      e.title = "🎴 #{event.user.name} drew **#{card[:name]}**!"
      e.image = Discordrb::Webhooks::EmbedImage.new(url: card[:image])
      e.color = 0xFFB6C1
      e.footer = Discordrb::Webhooks::EmbedFooter.new(
        text: "Gems remaining: #{user['gems']}"
      )
    end

    nil
  end
end
