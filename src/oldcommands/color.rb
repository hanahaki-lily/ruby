def register_color(bot)
  bot.command(:color) do |event, color_name|
    unless color_name
      event.respond "Usage: `!color <role>`"
      next
    end

    role = event.server.roles.find do |r|
      r.name.downcase == color_name.downcase
    end

    unless role && ALLOWED_COLORS.include?(role.name.downcase)
      event.respond "That is not a valid color role."
      next
    end

    event.user.roles
      .select { |r| ALLOWED_COLORS.include?(r.name.downcase) }
      .each { |r| event.user.remove_role(r) }

    event.user.add_role(role)
    event.respond "🎀 #{event.user.mention}, your color is now **#{role.name}**!"
    nil
  end
end
