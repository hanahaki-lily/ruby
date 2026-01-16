def register_hug(bot)
  bot.command(:hug) do |event, user_mention|
    unless user_mention
      event.respond "Usage: `!hug @user` ❤️"
      next
    end

    match = user_mention.match(/<@!?(\d+)>/)
    unless match
      event.respond "Please mention a valid user ❤️"
      next
    end

    server_id = event.server.id.to_s
    author_id = event.user.id.to_s
    target_id = match[1].to_i
    target    = event.server.member(target_id)

    unless target
      event.respond "I couldn't find that user 🥺"
      next
    end

    # Ensure user data exists
    ensure_user(server_id, author_id)
    user = $data[server_id][author_id]
    user["hugs_given"] ||= 0

    # ❤️ Self-hug
    if target.id == event.user.id
      embed = Discordrb::Webhooks::Embed.new(
        description: "❤️ **#{event.user.display_name}** hugs themselves gently.\nSelf-love is important too ✨",
        color: EMBED_COLOR
      )

      embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(
        url: event.user.avatar_url
      )

      embed.footer = Discordrb::Webhooks::EmbedFooter.new(
        text: "Moonlight Palace hugs",
        icon_url: event.server.icon_url
      )

      event.channel.send_embed('', embed)
      next
    end

    # 💕 Normal hug
    user["hugs_given"] += 1
    hugs = user["hugs_given"]

    message = HUG_MESSAGES.sample

    embed = Discordrb::Webhooks::Embed.new(
      description: "❤️ **#{event.user.display_name}** #{message} **#{target.display_name}**",
      color: EMBED_COLOR
    )

    embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(
      url: event.user.avatar_url
    )

    embed.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: "Total hugs given: #{hugs} ❤️",
      icon_url: event.server.icon_url
    )

    event.channel.send_embed('', embed)
    save_data($data)
    nil
  end
end
