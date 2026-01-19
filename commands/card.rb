# card.rb
# frozen_string_literal: true
require 'discordrb'
require 'json'
require_relative '../config/constants'

def register_card(bot)
  bot.command(:card) do |event, *args|
    server_id = event.server.id.to_s
    user_id = event.user.id.to_s
    card_name_input = args.join(" ").strip.downcase

    if card_name_input.empty?
      event.respond "Please provide a card name! Example: `!card Isabelle` 🌸"
      next
    end

    # Load data.json safely
    user_data = {}
    if File.exist?('data.json')
      file_content = File.read('data.json').strip
      unless file_content.empty?
        begin
          user_data = JSON.parse(file_content)
        rescue JSON::ParserError
          event.respond "⚠️ There was an error reading the database. Please contact the developer."
          next
        end
      end
    end

    # Fetch the user's cards (safely)
    cards_owned = user_data.dig(server_id, user_id, "cards") || {}

    # Find the card in constants.rb (case-insensitive)
    matched_card = AMIIBO_CARDS_SERIES_1.find { |c| c[:name].downcase == card_name_input }

    if matched_card.nil?
      event.respond "I couldn't find a card named '#{args.join(' ')}' 🌙"
      next
    end

    # Check if user owns it
    owned_count = cards_owned.find { |name, _| name.downcase == matched_card[:name].downcase }&.last || 0

    if owned_count <= 0
      event.respond "You don't own any of **#{matched_card[:name]}** yet! 🌸"
      next
    end

    # Send embed
    event.channel.send_embed do |embed|
      embed.title = "#{matched_card[:name]} 🌸"
      embed.description = "You own **#{owned_count}** of this card!"
      embed.color = EMBED_COLOR
      embed.image = Discordrb::Webhooks::EmbedImage.new(url: matched_card[:image])
    end
  end
end
