require 'discordrb'
require 'dotenv/load'
require 'json'
require 'time'

TOKEN = ENV['BOT_TOKEN']
PREFIX = '!'

DEVELOPER_IDS = [
  "325512370107580417"
]

EMBED_COLOR = 0x9B111E # Ruby Red ❤️
Thread.report_on_exception = true

bot = Discordrb::Commands::CommandBot.new(
  token: TOKEN,
  prefix: PREFIX
)

bot.ready do |event|
  bot.servers.each do |_, server|
    server_id = server.id.to_s
    next unless $data[server_id]

    valid_ids = server.members.map { |m| m.id.to_s }
    $data[server_id].keys.each do |uid|
      $data[server_id].delete(uid) unless valid_ids.include?(uid)
    end
  end

  save_data($data)
  puts "🧹 Startup cleanup complete"
end

# ---------------- STORAGE ----------------

def load_data
  if File.exist?('data.json')
    content = File.read('data.json').strip
    return {} if content.empty?
    begin
      JSON.parse(content)
    rescue JSON::ParserError
      puts "⚠️ data.json is corrupted. Recreating..."
      {}
    end
  else
    {}
  end
end

def save_data(data)
  File.write('data.json', JSON.pretty_generate(data))
end

# Load global data
$data = load_data
xp_cooldowns = {}

XP_COOLDOWN = 10 # seconds
DAILY_GEMS = 50
DAILY_COOLDOWN = 86_400 # 24 hours

# ---------------- Cards ----------------

AMIIBO_CARDS_SERIES_1 = [
  { name: "Isabelle", image: "https://nookipedia.com/wiki/Special:FilePath/001_Isabelle_amiibo_card_NA.png" },
  { name: "Tom Nook", image: "https://nookipedia.com/wiki/Special:FilePath/002_Tom_Nook_amiibo_card_NA.png" },
  { name: "DJ KK", image: "https://nookipedia.com/wiki/Special:FilePath/003_DJ_KK_amiibo_card_NA.png" },
  { name: "Sable", image: "https://nookipedia.com/wiki/Special:FilePath/004_Sable_amiibo_card_NA.png" },
  { name: "Kapp'n", image: "https://nookipedia.com/wiki/Special:FilePath/005_Kapp'n_amiibo_card_NA.png" },
  { name: "Resetti", image: "https://nookipedia.com/wiki/Special:FilePath/006_Resetti_amiibo_card_NA.png" },
  { name: "Joan", image: "https://nookipedia.com/wiki/Special:FilePath/007_Joan_amiibo_card_NA.png" },
  { name: "Timmy", image: "https://nookipedia.com/wiki/Special:FilePath/008_Timmy_amiibo_card_NA.png" },
  { name: "Digby", image: "https://nookipedia.com/wiki/Special:FilePath/009_Digby_amiibo_card_NA.png" },
  { name: "Pascal", image: "https://nookipedia.com/wiki/Special:FilePath/010_Pascal_amiibo_card_NA.png" },
  { name: "Harriet", image: "https://nookipedia.com/wiki/Special:FilePath/011_Harriet_amiibo_card_NA.png" },
  { name: "Redd", image: "https://nookipedia.com/wiki/Special:FilePath/012_Redd_amiibo_card_NA.png" },
  { name: "Saharah", image: "https://nookipedia.com/wiki/Special:FilePath/013_Saharah_amiibo_card_NA.png" },
  { name: "Luna", image: "https://nookipedia.com/wiki/Special:FilePath/014_Luna_amiibo_card_NA.png" },
  { name: "Tortimer", image: "https://nookipedia.com/wiki/Special:FilePath/015_Tortimer_amiibo_card_NA.png" },
  { name: "Lyle", image: "https://nookipedia.com/wiki/Special:FilePath/016_Lyle_amiibo_card_NA.png" },
  { name: "Lottie", image: "https://nookipedia.com/wiki/Special:FilePath/017_Lottie_amiibo_card_NA.png" },
  { name: "Bob", image: "https://nookipedia.com/wiki/Special:FilePath/018_Bob_amiibo_card_NA.png" },
  { name: "Fauna", image: "https://nookipedia.com/wiki/Special:FilePath/019_Fauna_amiibo_card_NA.png" },
  { name: "Curt", image: "https://nookipedia.com/wiki/Special:FilePath/020_Curt_amiibo_card_NA.png" },
  { name: "Portia", image: "https://nookipedia.com/wiki/Special:FilePath/021_Portia_amiibo_card_NA.png" },
  { name: "Leonardo", image: "https://nookipedia.com/wiki/Special:FilePath/022_Leonardo_amiibo_card_NA.png" },
  { name: "Cheri", image: "https://nookipedia.com/wiki/Special:FilePath/023_Cheri_amiibo_card_NA.png" },
  { name: "Kyle", image: "https://nookipedia.com/wiki/Special:FilePath/024_Kyle_amiibo_card_NA.png" },
  { name: "Al", image: "https://nookipedia.com/wiki/Special:FilePath/025_Al_amiibo_card_NA.png" },
  { name: "Renée", image: "https://nookipedia.com/wiki/Special:FilePath/026_Renée_amiibo_card_NA.png" },
  { name: "Lopez", image: "https://nookipedia.com/wiki/Special:FilePath/027_Lopez_amiibo_card_NA.png" },
  { name: "Jambette", image: "https://nookipedia.com/wiki/Special:FilePath/028_Jambette_amiibo_card_NA.png" },
  { name: "Rasher", image: "https://nookipedia.com/wiki/Special:FilePath/029_Rasher_amiibo_card_NA.png" },
  { name: "Tiffany", image: "https://nookipedia.com/wiki/Special:FilePath/030_Tiffany_amiibo_card_NA.png" },
  { name: "Sheldon", image: "https://nookipedia.com/wiki/Special:FilePath/031_Sheldon_amiibo_card_NA.png" },
  { name: "Bluebear", image: "https://nookipedia.com/wiki/Special:FilePath/032_Bluebear_amiibo_card_NA.png" },
  { name: "Bill", image: "https://nookipedia.com/wiki/Special:FilePath/033_Bill_amiibo_card_NA.png" },
  { name: "Kiki", image: "https://nookipedia.com/wiki/Special:FilePath/034_Kiki_amiibo_card_NA.png" },
  { name: "Deli", image: "https://nookipedia.com/wiki/Special:FilePath/035_Deli_amiibo_card_NA.png" },
  { name: "Alli", image: "https://nookipedia.com/wiki/Special:FilePath/036_Alli_amiibo_card_NA.png" },
  { name: "Kabuki", image: "https://nookipedia.com/wiki/Special:FilePath/037_Kabuki_amiibo_card_NA.png" },
  { name: "Patty", image: "https://nookipedia.com/wiki/Special:FilePath/038_Patty_amiibo_card_NA.png" },
  { name: "Jitters", image: "https://nookipedia.com/wiki/Special:FilePath/039_Jitters_amiibo_card_NA.png" },
  { name: "Gigi", image: "https://nookipedia.com/wiki/Special:FilePath/040_Gigi_amiibo_card_NA.png" },
  { name: "Quillson", image: "https://nookipedia.com/wiki/Special:FilePath/041_Quillson_amiibo_card_NA.png" },
  { name: "Marcie", image: "https://nookipedia.com/wiki/Special:FilePath/042_Marcie_amiibo_card_NA.png" },
  { name: "Puck", image: "https://nookipedia.com/wiki/Special:FilePath/043_Puck_amiibo_card_NA.png" },
  { name: "Shari", image: "https://nookipedia.com/wiki/Special:FilePath/044_Shari_amiibo_card_NA.png" },
  { name: "Octavian", image: "https://nookipedia.com/wiki/Special:FilePath/045_Octavian_amiibo_card_NA.png" },
  { name: "Winnie", image: "https://nookipedia.com/wiki/Special:FilePath/046_Winnie_amiibo_card_NA.png" },
  { name: "Knox", image: "https://nookipedia.com/wiki/Special:FilePath/047_Knox_amiibo_card_NA.png" },
  { name: "Sterling", image: "https://nookipedia.com/wiki/Special:FilePath/048_Sterling_amiibo_card_NA.png" },
  { name: "Bonbon", image: "https://nookipedia.com/wiki/Special:FilePath/049_Bonbon_amiibo_card_NA.png" },
  { name: "Punchy", image: "https://nookipedia.com/wiki/Special:FilePath/050_Punchy_amiibo_card_NA.png" },
  { name: "Freya", image: "https://nookipedia.com/wiki/Special:FilePath/051_Freya_amiibo_card_NA.png" },
  { name: "Bam", image: "https://nookipedia.com/wiki/Special:FilePath/052_Bam_amiibo_card_NA.png" },
  { name: "Tasha", image: "https://nookipedia.com/wiki/Special:FilePath/053_Tasha_amiibo_card_NA.png" },
  { name: "Cally", image: "https://nookipedia.com/wiki/Special:FilePath/054_Cally_amiibo_card_NA.png" },
  { name: "Ed", image: "https://nookipedia.com/wiki/Special:FilePath/055_Ed_amiibo_card_NA.png" },
  { name: "Lopez", image: "https://nookipedia.com/wiki/Special:FilePath/056_Lopez_amiibo_card_NA.png" },
  { name: "Nana", image: "https://nookipedia.com/wiki/Special:FilePath/057_Nana_amiibo_card_NA.png" },
  { name: "Timbra", image: "https://nookipedia.com/wiki/Special:FilePath/058_Timbra_amiibo_card_NA.png" },
  { name: "Shep", image: "https://nookipedia.com/wiki/Special:FilePath/059_Shep_amiibo_card_NA.png" },
  { name: "Ankha", image: "https://nookipedia.com/wiki/Special:FilePath/060_Ankha_amiibo_card_NA.png" },
  { name: "Carmen", image: "https://nookipedia.com/wiki/Special:FilePath/061_Carmen_amiibo_card_NA.png" },
  { name: "Deirdre", image: "https://nookipedia.com/wiki/Special:FilePath/062_Deirdre_amiibo_card_NA.png" },
  { name: "Papi", image: "https://nookipedia.com/wiki/Special:FilePath/063_Papi_amiibo_card_NA.png" },
  { name: "Chester", image: "https://nookipedia.com/wiki/Special:FilePath/064_Chester_amiibo_card_NA.png" },
  { name: "Sydney", image: "https://nookipedia.com/wiki/Special:FilePath/065_Sydney_amiibo_card_NA.png" },
  { name: "Diana", image: "https://nookipedia.com/wiki/Special:FilePath/066_Diana_amiibo_card_NA.png" },
  { name: "Lobo", image: "https://nookipedia.com/wiki/Special:FilePath/067_Lobo_amiibo_card_NA.png" },
  { name: "Benjamin", image: "https://nookipedia.com/wiki/Special:FilePath/068_Benjamin_amiibo_card_NA.png" },
  { name: "Melba", image: "https://nookipedia.com/wiki/Special:FilePath/069_Melba_amiibo_card_NA.png" },
  { name: "Stitches", image: "https://nookipedia.com/wiki/Special:FilePath/070_Stitches_amiibo_card_NA.png" },
  { name: "Lucky", image: "https://nookipedia.com/wiki/Special:FilePath/071_Lucky_amiibo_card_NA.png" },
  { name: "Pinky", image: "https://nookipedia.com/wiki/Special:FilePath/072_Pinky_amiibo_card_NA.png" },
  { name: "Mira", image: "https://nookipedia.com/wiki/Special:FilePath/073_Mira_amiibo_card_NA.png" },
  { name: "Kabuki", image: "https://nookipedia.com/wiki/Special:FilePath/074_Kabuki_amiibo_card_NA.png" },
  { name: "Coco", image: "https://nookipedia.com/wiki/Special:FilePath/075_Coco_amiibo_card_NA.png" },
  { name: "Pango", image: "https://nookipedia.com/wiki/Special:FilePath/076_Pango_amiibo_card_NA.png" },
  { name: "Bea", image: "https://nookipedia.com/wiki/Special:FilePath/077_Bea_amiibo_card_NA.png" },
  { name: "Violet", image: "https://nookipedia.com/wiki/Special:FilePath/078_Violet_amiibo_card_NA.png" },
  { name: "Kody", image: "https://nookipedia.com/wiki/Special:FilePath/079_Kody_amiibo_card_NA.png" },
  { name: "Raymond", image: "https://nookipedia.com/wiki/Special:FilePath/080_Raymond_amiibo_card_NA.png" },
  { name: "Fuchsia", image: "https://nookipedia.com/wiki/Special:FilePath/081_Fuchsia_amiibo_card_NA.png" },
  { name: "Eugene", image: "https://nookipedia.com/wiki/Special:FilePath/082_Eugene_amiibo_card_NA.png" },
  { name: "Lolly", image: "https://nookipedia.com/wiki/Special:FilePath/083_Lolly_amiibo_card_NA.png" },
  { name: "Flurry", image: "https://nookipedia.com/wiki/Special:FilePath/084_Flurry_amiibo_card_NA.png" },
  { name: "Curt", image: "https://nookipedia.com/wiki/Special:FilePath/085_Curt_amiibo_card_NA.png" },
  { name: "Clay", image: "https://nookipedia.com/wiki/Special:FilePath/086_Clay_amiibo_card_NA.png" },
  { name: "Alice", image: "https://nookipedia.com/wiki/Special:FilePath/087_Alice_amiibo_card_NA.png" },
  { name: "Phoebe", image: "https://nookipedia.com/wiki/Special:FilePath/088_Phoebe_amiibo_card_NA.png" },
  { name: "Anabelle", image: "https://nookipedia.com/wiki/Special:FilePath/089_Anabelle_amiibo_card_NA.png" },
  { name: "Claude", image: "https://nookipedia.com/wiki/Special:FilePath/090_Claude_amiibo_card_NA.png" },
  { name: "Cleo", image: "https://nookipedia.com/wiki/Special:FilePath/091_Cleo_amiibo_card_NA.png" },
  { name: "Vesta", image: "https://nookipedia.com/wiki/Special:FilePath/092_Vesta_amiibo_card_NA.png" },
  { name: "Camofrog", image: "https://nookipedia.com/wiki/Special:FilePath/093_Camofrog_amiibo_card_NA.png" },
  { name: "Bertha", image: "https://nookipedia.com/wiki/Special:FilePath/094_Bertha_amiibo_card_NA.png" },
  { name: "Rodney", image: "https://nookipedia.com/wiki/Special:FilePath/095_Rodney_amiibo_card_NA.png" },
  { name: "Carrie", image: "https://nookipedia.com/wiki/Special:FilePath/096_Carrie_amiibo_card_NA.png" },
  { name: "Felicity", image: "https://nookipedia.com/wiki/Special:FilePath/097_Felicity_amiibo_card_NA.png" },
  { name: "Bud", image: "https://nookipedia.com/wiki/Special:FilePath/098_Bud_amiibo_card_NA.png" },
  { name: "Violet", image: "https://nookipedia.com/wiki/Special:FilePath/099_Violet_amiibo_card_NA.png" },
  { name: "Walker", image: "https://nookipedia.com/wiki/Special:FilePath/100_Walker_amiibo_card_NA.png" }
]
CARD_COST = 50
TOTAL_CARDS = AMIIBO_CARDS_SERIES_1.size

# Ensure user exists in the server
def ensure_user(server_id, user_id)
  $data[server_id] ||= {}
  $data[server_id][user_id] ||= { "xp" => 0, "level" => 1, "gems" => 0, "cards" => {} }
  $data
end


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

# ---------------- HUG MESSAGES ----------------
HUG_MESSAGES = [
  "wraps them in a warm hug ❤️",
  "pulls them close under the moonlight 🌙❤️",
  "gives the softest, coziest hug ✨❤️",
  "holds them tight with gentle care 🌸❤️",
  "shares a comforting hug full of love 💖"
]

# ---------------- MESSAGE XP + ECONOMY ----------------

bot.message do |event|
  next if event.user.bot_account?

  server_id = event.server.id.to_s
  user_id = event.user.id.to_s
  now = Time.now.to_i

  xp_cooldowns[user_id] ||= 0
  next if now - xp_cooldowns[user_id] < XP_COOLDOWN
  xp_cooldowns[user_id] = now

  $data[server_id] ||= {}
  $data[server_id][user_id] ||= {
    "xp" => 0,
    "level" => 1,
    "gems" => 0,
    "last_daily" => 0
  }

  xp_gain = rand(5..15)
  gem_gain = rand(1..3)

  $data[server_id][user_id]["xp"] += xp_gain
  $data[server_id][user_id]["gems"] += gem_gain

  leveled_up = false

  loop do
    level = $data[server_id][user_id]["level"]
    required_xp = level * 100
    break if $data[server_id][user_id]["xp"] < required_xp

    $data[server_id][user_id]["level"] += 1
    leveled_up = true
  end

  if leveled_up
    new_level = $data[server_id][user_id]["level"]

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

  save_data($data)
end

bot.member_leave do |event|
  server_id = event.server.id.to_s
  user_id = event.user.id.to_s

  next unless $data[server_id]

  if $data[server_id].delete(user_id)
    save_data($data)
    puts "🧹 Removed user #{user_id} from server #{server_id}"
  end
end

# ---------------- Developer Commands ----------------

bot.command(:devset) do |event, user_mention, stat, amount|
  # 🔒 Dev-only check
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
  user[stat] = amount

  if stat == "level"
  user["level"] = [user["level"], 1].max
  user["xp"] = (user["level"] - 1) * 100
  end

  user["xp"]   = [user["xp"], 0].max
  user["gems"] = [user["gems"], 0].max

  if stat == "xp"
  min_xp = (user["level"] - 1) * 100
  user["xp"] = [amount, min_xp].max
end

save_data($data)

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
end

# ---------------- COMMANDS ----------------

bot.command(:hug) do |event, user_mention|
  unless user_mention
    event.respond "Usage: `!hug @user` ❤️"
    nil
  end

  match = user_mention.match(/<@!?(\d+)>/)
  unless match
    event.respond "Please mention a valid user ❤️"
    nil
  end

  server_id = event.server.id.to_s
  target_id = match[1].to_i
  target = event.server.member(target_id)

  unless target
    event.respond "I couldn't find that user 🥺"
    nil
  end

  $data[server_id] ||= {}
  $data[server_id][event.user.id.to_s] ||= {}
  $data[server_id][event.user.id.to_s]["hugs_given"] ||= 0

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
    nil
  end

  # Increment hug counter
  $data[server_id][event.user.id.to_s]["hugs_given"] += 1
  hugs = $data[server_id][event.user.id.to_s]["hugs_given"]

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

bot.command(:ping) { |event| event.respond "Pong! 🏓" }

# 🌙 !level

bot.command(:level) do |event, user_mention|
  server_id = event.server.id.to_s

  # Determine target user
  target =
    if user_mention
      match = user_mention.match(/<@!?(\d+)>/)
      match ? event.server.member(match[1].to_i) : nil
    else
      event.user
    end

  unless target
    event.respond "Please mention a valid user ❤️"
    next
  end

  target_id = target.id.to_s

  $data[server_id] ||= {}
  $data[server_id][target_id] ||= {
    "xp" => 0,
    "level" => 1,
    "gems" => 0
  }

  # Rank calculation
  ranked = $data[server_id].sort_by do |_, d|
    [-d["level"], -d["xp"]]
  end

  rank_index = ranked.index { |uid, _| uid == target_id }
  rank = rank_index ? rank_index + 1 : "?"
  crown = rank == 1 ? " 👑" : ""

  xp    = $data[server_id][target_id]["xp"]
  level = $data[server_id][target_id]["level"]
  gems  = $data[server_id][target_id]["gems"]

  # ---------------- XP PROGRESS (CUMULATIVE) ----------------

  current_level_total = (level - 1) * 100
  next_level_total    = level * 100

  display_xp = [xp, current_level_total].max
  progress_xp = display_xp - current_level_total
  needed_xp   = next_level_total - current_level_total

  blocks = 10
  filled = ((progress_xp.to_f / needed_xp) * blocks).floor
  filled = [[filled, 0].max, blocks].min

  bar = "▰" * filled + "▱" * (blocks - filled)

  # ---------------- EMBED ----------------

  embed = Discordrb::Webhooks::Embed.new(
    title: "🌙 #{target.username}'s Level",
    color: EMBED_COLOR
  )

  embed.description = <<~DESC
    🏆 **Server Rank:** ##{rank}#{crown}
    ✨ **Level:** #{level}
    💎 **Wish Gems:** #{gems}

    #{bar}
    #{progress_xp}/#{needed_xp} XP
  DESC

  embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(
    url: target.avatar_url
  )

  embed.footer = Discordrb::Webhooks::EmbedFooter.new(
    text: "Keep chatting to earn XP & Wish Gems",
    icon_url: event.server.icon_url
  )

  event.channel.send_embed('', embed)
  nil
end

# ✨ !leaderboard
bot.command(:leaderboard) do |event|
  server_id = event.server.id.to_s
  users = $data[server_id] || {}

  desc = users
    .sort_by { |_, d| [-d["level"], -d["xp"]] }
    .first(10)
    .map.with_index(1) do |(uid, d), i|
      member = event.server.member(uid.to_i)
      "#{i}. **#{member&.display_name || 'Unknown'}** — Level: #{d['level']} (XP: #{d['xp']})"
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

  $data[server_id] ||= {}
  $data[server_id][user_id] ||= {
    "xp" => 0,
    "level" => 1,
    "gems" => 0,
    "last_daily" => 0
  }

  user = $data[server_id][user_id]

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
  save_data($data)

  event.respond "🎁 You claimed **#{DAILY_GEMS} 💎 Wish Gems**!"
end

# ---------------- MODERATION ----------------

bot.command(:say, required_permissions: [:administrator]) do |event|
  parts = event.message.content.split(' ', 3)

  unless parts.length >= 3
    event.respond "Usage: `!say <channel_id> <message>`"
    next
  end

  channel_id = parts[1].to_i
  content = parts[2]

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
end


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

# ---------------- !wish command ----------------

bot.command(:wish) do |event|
  server_id = event.server.id.to_s
  user_id = event.user.id.to_s

  ensure_user(server_id, user_id)
  user = $data[server_id][user_id]
  user["cards"] ||= {}

  if user["gems"] < CARD_COST
    event.respond "❌ You need #{CARD_COST} gems to wish!"
    next
  end

  user["gems"] -= CARD_COST

  card = AMIIBO_CARDS_SERIES_1.sample
  user["cards"][card[:name]] ||= 0
  user["cards"][card[:name]] += 1

  save_data($data)

  event.channel.send_embed do |e|
    e.title = "🎴 #{event.user.name} drew **#{card[:name]}**!"
    e.image = Discordrb::Webhooks::EmbedImage.new(url: card[:image])
    e.color = 0xFFB6C1
    e.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: "Gems remaining: #{user['gems']}"
    )
  end
end


# ---------------- !collection command ----------------

bot.command(:collection) do |event|
  server_id = event.server.id.to_s
  user_id = event.user.id.to_s
  ensure_user(server_id, user_id)
  user = $data[server_id][user_id]

  cards_owned = user["cards"] || {}
  total_owned = cards_owned.values.sum
  unique_owned = cards_owned.keys.size

  if cards_owned.empty?
    event.respond "❌ You don't have any cards yet! Try `!wish` to draw some."
    next
  end

  description = cards_owned.map do |name, count|
    "#{name}: #{count}"
  end.join("\n")

  event.channel.send_embed do |e|
    e.title = "#{event.user.name}'s Collection"
    e.description = description
    e.footer = Discordrb::Webhooks::EmbedFooter.new(
      text: "Unique cards: #{unique_owned}/#{TOTAL_CARDS} | Total cards: #{total_owned}"
    )
    e.color = 0xFFD700
  end
end

puts "Ruby is ready! 🌸"
bot.run
