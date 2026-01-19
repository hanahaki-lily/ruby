TOKEN = ENV['BOT_TOKEN']
PREFIX = '!'

EMBED_COLOR = 0x9B111E

DEVELOPER_IDS = ["325512370107580417"]

XP_COOLDOWN = 10
DAILY_GEMS = 50
DAILY_COOLDOWN = 86_400
GEMS_PER_LEVEL = 10

LEVEL_ROLES = {
  5  => "Twilight Wanderer",
  10 => "Crescent Ascendant",
  20 => "Starlit Voyager",
  30 => "Lunar Adept",
  50 => "Eclipse Paragon"
}

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