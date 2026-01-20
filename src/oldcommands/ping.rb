def register_ping(bot)
  bot.command(:ping) do |event|
    event.respond "Pong! 🏓"
    nil
  end
end
