require 'discordrb'
require 'dotenv/load'
require 'colorize'

require_relative 'config/constants'
require_relative 'helpers/storage'

bot = Discordrb::Commands::CommandBot.new(
  token: TOKEN,
  prefix: PREFIX
)

$data = load_data

require_relative 'events/ready_cleanup'
require_relative 'events/message_xp'
require_relative 'events/member_leave'

register_ready_cleanup(bot)
register_message_xp(bot)
register_member_leave(bot)

Dir[File.join(__dir__, 'commands', '*.rb')].each { |file| require file }

register_level(bot)
register_leaderboard(bot)
register_devset(bot)
register_wish(bot)
register_collection(bot)
register_hug(bot)
register_daily(bot)
register_color(bot)
register_moderation(bot)
register_ping(bot)
register_card(bot)
register_help(bot)

puts "Ruby is ready! 🌸".red
bot.run
