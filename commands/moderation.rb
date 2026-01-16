def register_moderation(bot)

  # 🗣️ !say (admin-only embed relay)
  bot.command(:say, required_permissions: [:administrator]) do |event|
    parts = event.message.content.split(' ', 3)

    unless parts.length >= 3
      event.respond "Usage: `!say <channel_id> <message>`"
      next
    end

    channel_id = parts[1].to_i
    content    = parts[2]

    channel = bot.channel(channel_id)
    unless channel
      event.respond "❌ I couldn't find that channel."
      next
    end

    embed = Discordrb::Webhooks::Embed.new(
      description: content,
      color: EMBED_COLOR
    )

    embed.author = Discordrb::Webhooks::EmbedAuthor.new(
      name: event.user.username,
      icon_url: event.user.avatar_url
    )

    embed.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: event.server.name,
      icon_url: event.server.icon_url
    )

    channel.send_embed('', embed)
    event.respond "✅ Embed sent!"
    nil
  end

  # 👢 !kick
  bot.command(:kick, required_permissions: [:kick_members]) do |event, user|
    unless user
      event.respond "Usage: `!kick @user`"
      next
    end

    event.server.kick(user)
    event.respond "#{user.mention} was kicked."
    nil
  rescue
    event.respond "❌ Could not kick that user."
  end

  # 🔨 !ban
  bot.command(:ban, required_permissions: [:ban_members]) do |event, user|
    unless user
      event.respond "Usage: `!ban @user`"
      next
    end

    event.server.ban(user)
    event.respond "#{user.mention} was banned."
    nil
  rescue
    event.respond "❌ Could not ban that user."
  end

  # 🔓 !unban
  bot.command(:unban, required_permissions: [:ban_members]) do |event, user_id|
    unless user_id
      event.respond "Usage: `!unban <user_id>`"
      next
    end

    event.server.unban(user_id.to_i)
    event.respond "🔓 User unbanned."
    nil
  rescue
    event.respond "❌ Could not unban that user."
  end
end
