class Wish
  attr_reader :name, :description

  def initialize
    @name = "wish"
    @description = "Spend gems to draw a random Animal Crossing Amiibo card!"
  end

  def execute(event)
    server_id = event.server.id.to_s
    user_id   = event.user.id.to_s
    card_cost = 50 

    # 1. Ensure data exists
    $data[server_id] ||= {}
    $data[server_id][user_id] ||= { "gems" => 0, "cards" => {}, "level" => 1, "xp" => 0 }
    
    user = $data[server_id][user_id]
    user["cards"] ||= {}

    # 2. Check gems
    if user["gems"] < card_cost
      event.respond(content: "❌ You need #{card_cost} gems! (You have: #{user['gems']})", ephemeral: true)
      return
    end

    # 3. Pick a card
    # IMPORTANT: Ensure AMIIBO_CARDS is defined in your index.rb
    card = AMIIBO_CARDS.sample
    card_name = card[:name]

    # 4. Update User Data (Cleaned)
    user["gems"] -= card_cost
    user["cards"][card_name] ||= 0
    user["cards"][card_name] += 1

    # 5. Save data
    begin
      File.write(DATA_FILE, JSON.pretty_generate($data))
    rescue => e
      puts "[ERROR] Save failed: #{e.message}"
    end

    # 6. Respond
    event.respond(embeds: [
      {
        title: "🎴 #{event.user.name} made a wish...",
        description: "And drew **#{card_name}**!",
        image: { url: card[:image] },
        color: EMBED_COLOR,
        footer: { text: "Gems remaining: #{user['gems']}" }
      }
    ])
  end
end