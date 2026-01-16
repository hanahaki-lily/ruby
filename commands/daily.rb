def register_daily(bot)
  bot.command(:daily) do |event|
    server_id = event.server.id.to_s
    user_id   = event.user.id.to_s
    now       = Time.now.to_i

    # Ensure user data exists
    ensure_user(server_id, user_id)
    user = $data[server_id][user_id]

    # Ensure last_daily exists
    user["last_daily"] ||= 0

    elapsed = now - user["last_daily"]

    if elapsed < DAILY_COOLDOWN
      remaining = DAILY_COOLDOWN - elapsed
      hours     = remaining / 3600
      minutes   = (remaining % 3600) / 60

      event.respond "⏳ Come back in **#{hours}h #{minutes}m**!"
      next
    end

    user["gems"]       += DAILY_GEMS
    user["last_daily"] = now
    save_data($data)

    event.respond "🎁 You claimed **#{DAILY_GEMS} 💎 Wish Gems**!"
    nil
  end
end
