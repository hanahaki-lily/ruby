# help.rb
# frozen_string_literal: true
require 'discordrb'
require_relative '../config/constants'

# Manually store descriptions for your commands
COMMAND_DESCRIPTIONS = {
  collection: "View your full card collection.",
  card: "View a specific card by name: !card <cardname>.",
  help: "Shows this help message.",
  level: "Check your level and XP.",
  daily: "Claim your daily gems.",
  hug: "Send a hug to another user.",
  leaderboard: "View the server's level leaderboard.",
  ping: "Bot test command.",
  color: "Set your role color.",
  devset: "Developer command to set user data.",
  wish: "Make a wish for a card.",
  say: "Make the bot say something.",
  kick: "Kick a user from the server.",
  ban: "Ban a user from the server.",
  unban: "Unban a user from the server."
  # add more as needed
}

def register_help(bot)
  bot.command(:help) do |event|
    command_list = bot.commands.keys.map do |name|
      desc = COMMAND_DESCRIPTIONS[name.to_sym] || "No description provided."
      "**#{PREFIX}#{name}** - #{desc}"
    end

    if command_list.empty?
      event.respond "I don't have any commands registered yet! 🌸"
      next
    end

    event.channel.send_embed do |embed|
      embed.title = "Ruby's Command List 🌸"
      embed.description = command_list.join("\n")
      embed.color = EMBED_COLOR
      embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "Use #{PREFIX} before commands")
    end
  end
end
