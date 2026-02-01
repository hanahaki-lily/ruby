class Daily
  attr_reader :name, :description

  # Constants (Adjust these to your liking)
  DAILY_COOLDOWN = 86400 # 24 hours in seconds
  DAILY_GEMS     = 100

  def initialize
    @name = "daily"
    @description = "Claim your daily 💎 Wish Gems!"
  end

  def execute(event)
    server_id = event.server.id.to_s
    user_id   = event.user.id.to_s
    now       = Time.now.to_i

    # 1. Ensure user data exists
    $data[server_id] ||= {}
    $data[server_id][user_id] ||= { 
      "gems" => 0, 
      "cards" => {}, 
      "level" => 1, 
      "xp" => 0,
      "last_daily" => 0 
    }
    
    user = $data[server_id][user_id]
    user["last_daily"] ||= 0

    # 2. Check Cooldown
    elapsed = now - user["last_daily"]

    if elapsed < DAILY_COOLDOWN
      next_available = user["last_daily"] + DAILY_COOLDOWN
      # Using Discord's Relative Timestamp: <t:timestamp:R>
      event.respond(
        content: "⏳ You've already claimed your daily gems! You can claim them again <t:#{next_available}:R>.",
        ephemeral: true
      )
      return
    end

    # 3. Update Data
    user["gems"] ||= 0
    user["gems"] += DAILY_GEMS
    user["last_daily"] = now

    # 4. Save to file
    begin
      File.write(DATA_FILE, JSON.pretty_generate($data))
    rescue => e
      puts "[ERROR] Daily save failed: #{e.message}"
    end

    # 5. Success Response
    event.respond(embeds: [{
      title: "🎁 Daily Reward Claimed!",
      description: "You received **#{DAILY_GEMS} 💎 Wish Gems**!\nTotal Gems: **#{user['gems']}**",
      color: 0x58D68D, # Green color
      footer: { text: "Come back tomorrow for more!" }
    }])
  end
end