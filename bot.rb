require 'discordrb'
require 'dotenv/load'
require 'colorize'

require_relative 'src/config/constants'
require_relative 'src/helpers/storage'
require_relative 'src/utils/data_handler'


bot = Discordrb::Commands::CommandBot.new(
  token: TOKEN,
  prefix: PREFIX
)

$data = load_data

require_relative 'src/oldevents/ready_cleanup'
require_relative 'src/oldevents/message_xp'
require_relative 'src/oldevents/member_leave'

register_ready_cleanup(bot)
register_message_xp(bot)
register_member_leave(bot)

Dir[File.join(__dir__, 'src/oldcommands', '*.rb')].each { |file| require file }

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
