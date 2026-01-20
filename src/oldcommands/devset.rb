def register_devset(bot)
  bot.command(:devset) do |event, user_mention, stat, amount|
    unless DEVELOPER_IDS.include?(event.user.id.to_s)
      event.respond "❌ This command is developer-only."
      next
    end

    unless user_mention && stat && amount
      event.respond "Usage: `!devset @user <xp|level|gems> <amount>`"
      next
    end

    match = user_mention.match(/<@!?(\d+)>/)
    unless match
      event.respond "Please mention a valid user."
      next
    end

    server_id = event.server.id.to_s
    target_id = match[1]

    ensure_user(server_id, target_id)
    user = $data[server_id][target_id]
    user["cards"] ||= {}

    amount = amount.to_i

    unless %w[xp level gems].include?(stat.downcase)
      event.respond "Stat must be one of: `xp`, `level`, `gems`"
      next
    end

    if amount < 0
      event.respond "Amount must be 0 or higher."
      next
    end

    stat = stat.downcase

    # ---------------- Apply stat ----------------
    case stat
    when "level"
      user["level"] = [amount, 1].max
      user["xp"] = (user["level"] - 1) * 100
    when "xp"
      min_xp = (user["level"] - 1) * 100
      user["xp"] = [amount, min_xp].max
    when "gems"
      user["gems"] = [amount, 0].max
    end

    user["xp"]   = [user["xp"], 0].max
    user["gems"] = [user["gems"], 0].max

    save_data($data)

    # ---------------- Embed response ----------------
    event.channel.send_embed do |e|
      e.title = "🛠️ Developer Update"
      e.description = <<~DESC
        **User:** <@#{target_id}>
        **Stat:** #{stat.upcase}
        **New Value:** #{amount}
      DESC
      e.color = EMBED_COLOR
      e.footer = Discordrb::Webhooks::EmbedFooter.new(
        text: "Developer command"
      )
    end

    nil
  end
end
