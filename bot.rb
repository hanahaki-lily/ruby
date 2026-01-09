require 'discordrb'
require 'dotenv/load'
require 'json'
require 'time'

TOKEN = ENV['BOT_TOKEN']
PREFIX = '!'

EMBED_COLOR = 0x9B111E # Ruby Red ❤️

bot = Discordrb::Commands::CommandBot.new(
  token: TOKEN,
  prefix: PREFIX
)

# ---------------- STORAGE ----------------
def load_data
  File.exist?('data.json') ? JSON.parse(File.read('data.json')) : {}
end

def save_data(data)
  File.write('data.json', JSON.pretty_generate(data))
end

data = load_data
xp_cooldowns = {}

XP_COOLDOWN = 10 # seconds
DAILY_GEMS = 50
DAILY_COOLDOWN = 86_400 # 24 hours

# ---------------- LEVEL ROLES ----------------
LEVEL_ROLES = {
  5  => "Twilight Wanderer",
  10 => "Crescent Ascendant",
  20 => "Starlit Voyager",
  30 => "Lunar Adept",
  50 => "Eclipse Paragon"
}

# ---------------- COLOR ROLES ----------------
ALLOWED_COLORS = [
  "RoseQuartz", "Amethyst", "Malachite", "Sapphire", "Ruby",
  "Aquamarine", "Diamond", "Onyx", "Amber", "Jade"
].map(&:downcase)

# ---------------- MESSAGE XP + ECONOMY ----------------
bot.message do |event|
  next if event.user.bot_account?

  server_id = event.server.id.to_s
  user_id = event.user.id.to_s
  now = Time.now.to_i

  xp_cooldowns[user_id] ||= 0
  next if now - xp_cooldowns[user_id] < XP_COOLDOWN
  xp_cooldowns[user_id] = now

  data[server_id] ||= {}
  data[server_id][user_id] ||= {
    "xp" => 0,
    "level" => 1,
    "gems" => 0,
    "last_daily" => 0
  }

  xp_gain = rand(5..15)
  gem_gain = rand(1..3)

  data[server_id][user_id]["xp"] += xp_gain
  data[server_id][user_id]["gems"] += gem_gain

  leveled_up = false

  loop do
    level = data[server_id][user_id]["level"]
    required_xp = level * 100
    break if data[server_id][user_id]["xp"] < required_xp

    data[server_id][user_id]["level"] += 1
    leveled_up = true
  end

  if leveled_up
    new_level = data[server_id][user_id]["level"]

    embed = Discordrb::Webhooks::Embed.new(
      title: "🌸 Level Up!",
      description: "#{event.user.mention} reached **Level #{new_level}** ✨",
      color: EMBED_COLOR
    )

    embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(
      url: event.user.avatar_url
    )

    embed.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: "Moonlight Palace",
      icon_url: event.server.icon_url
    )

    event.channel.send_embed('', embed)

    # Remove old level roles
    event.user.roles
      .select { |r| LEVEL_ROLES.values.include?(r.name) }
      .each { |r| event.user.remove_role(r) }

    # Assign highest valid role
    LEVEL_ROLES.sort.each do |lvl, role_name|
      if new_level >= lvl
        role = event.server.roles.find { |r| r.name == role_name }
        event.user.add_role(role) if role
      end
    end
  end

  save_data(data)
end

# ---------------- COMMANDS ----------------

bot.command(:ping) { |event| event.respond "Pong! 🏓" }

# 🌙 !level
bot.command(:level) do |event|
  server_id = event.server.id.to_s
  user_id = event.user.id.to_s

  user = data.dig(server_id, user_id) || { "xp" => 0, "level" => 1, "gems" => 0 }

  xp = user["xp"]
  level = user["level"]
  gems = user["gems"]

  next_xp = level * 100
  progress = xp % next_xp

  blocks = 10
  filled = ((progress.to_f / next_xp) * blocks).round
  bar = "▰" * filled + "▱" * (blocks - filled)

  embed = Discordrb::Webhooks::Embed.new(
    title: "🌙 #{event.user.username}'s Level",
    color: EMBED_COLOR
  )

  embed.description = <<~DESC
    ✨ **Level:** #{level}
    💎 **Wish Gems:** #{gems}

    #{bar}
    #{progress}/#{next_xp} XP
  DESC

  embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(
    url: event.user.avatar_url
  )

  embed.footer = Discordrb::Webhooks::EmbedFooter.new(
    text: "Keep chatting to earn XP & Wish Gems",
    icon_url: event.server.icon_url
  )

  event.channel.send_embed('', embed)
end

# ✨ !leaderboard
bot.command(:leaderboard) do |event|
  server_id = event.server.id.to_s
  users = data[server_id] || {}

  desc = users
    .sort_by { |_, d| [-d["level"], -d["xp"]] }
    .first(5)
    .map.with_index(1) do |(uid, d), i|
      member = event.server.member(uid.to_i)
      "#{i}. **#{member&.display_name || 'Unknown'}** — Level #{d['level']} 💎 #{d['gems']}"
    end.join("\n")

  embed = Discordrb::Webhooks::Embed.new(
    title: "✨ Server Leaderboard",
    description: desc.empty? ? "No data yet!" : desc,
    color: EMBED_COLOR
  )

  embed.footer = Discordrb::Webhooks::EmbedFooter.new(
    text: "Moonlight Palace Rankings",
    icon_url: event.server.icon_url
  )

  event.channel.send_embed('', embed)
end

# 🎀 !color
bot.command(:color) do |event, color_name|
  unless color_name
    event.respond "Usage: `!color <role>`"
    next
  end

  role = event.server.roles.find { |r| r.name.downcase == color_name.downcase }
  unless role && ALLOWED_COLORS.include?(role.name.downcase)
    event.respond "That is not a valid color role."
    next
  end

  event.user.roles
    .select { |r| ALLOWED_COLORS.include?(r.name.downcase) }
    .each { |r| event.user.remove_role(r) }

  event.user.add_role(role)
  event.respond "🎀 #{event.user.mention}, your color is now **#{role.name}**!"
end

# 🛍️ !shop
bot.command(:shop) do |event|
  embed = Discordrb::Webhooks::Embed.new(
    title: "🛍️ Wish Shop",
    description: "✨ Coming soon!\nSpend your **💎 Wish Gems** on cute rewards.",
    color: EMBED_COLOR
  )

  embed.footer = Discordrb::Webhooks::EmbedFooter.new(
    text: "Moonlight Palace",
    icon_url: event.server.icon_url
  )

  event.channel.send_embed('', embed)
end

# 🎁 !daily
bot.command(:daily) do |event|
  server_id = event.server.id.to_s
  user_id = event.user.id.to_s
  now = Time.now.to_i

  data[server_id] ||= {}
  data[server_id][user_id] ||= {
    "xp" => 0,
    "level" => 1,
    "gems" => 0,
    "last_daily" => 0
  }

  user = data[server_id][user_id]

  # Ensure last_daily always exists
  user["last_daily"] ||= 0

  elapsed = now - user["last_daily"]

  if elapsed < DAILY_COOLDOWN
    remaining = DAILY_COOLDOWN - elapsed
    hours = remaining / 3600
    minutes = (remaining % 3600) / 60

    event.respond "⏳ Come back in **#{hours}h #{minutes}m**!"
    next
  end

  user["gems"] += DAILY_GEMS
  user["last_daily"] = now
  save_data(data)

  event.respond "🎁 You claimed **#{DAILY_GEMS} 💎 Wish Gems**!"
end


# ---------------- MODERATION ----------------

bot.command(:kick, required_permissions: [:kick_members]) do |event, user|
  event.server.kick(user)
  event.respond "#{user} was kicked."
rescue
  event.respond "Could not kick that user."
end

bot.command(:ban, required_permissions: [:ban_members]) do |event, user|
  event.server.ban(user)
  event.respond "#{user} was banned."
rescue
  event.respond "Could not ban that user."
end

bot.command(:unban, required_permissions: [:ban_members]) do |event, user_id|
  event.server.unban(user_id.to_i)
  event.respond "🔓 User unbanned."
rescue
  event.respond "Could not unban that user."
end

puts "Ruby is ready! 🌸"
bot.run
