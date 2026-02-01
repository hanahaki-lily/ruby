class Collection
  attr_reader :name, :description

  def initialize
    @name = "collection"
    @description = "View your Animal Crossing card collection."
  end

  def execute(event)
    server_id = event.server.id.to_s
    user_id   = event.user.id.to_s
    user      = $data[server_id]&.[](user_id)

    if !user || user["cards"].nil? || user["cards"].empty?
      event.respond(content: "❌ You don't have any cards yet! Use `/wish` to start your collection.", ephemeral: true)
      return
    end

    # Sort cards alphabetically
    sorted_cards = user["cards"].sort_by { |name, _| name }
    
    # Send page 0
    send_collection_page(event, sorted_cards, 0)
  end

  def send_collection_page(event, all_cards, page)
    per_page = 10
    max_pages = (all_cards.size / per_page.to_f).ceil
    start_index = page * per_page
    page_items = all_cards[start_index, per_page]

    desc = page_items.map { |name, count| "• **#{name}**: x#{count}" }.join("\n")

    unique = all_cards.size
    total = all_cards.map { |_, count| count }.sum

    embed = {
      title: "#{event.user.name}'s Collection",
      description: desc,
      color: 0xFFD700,
      footer: { text: "Page #{page + 1} of #{max_pages} | Unique: #{unique} | Total: #{total}" }
    }

    # Create Buttons
    components = Discordrb::Components::View.new do |view|
      view.row do |row|
        row.button(label: '◀️', style: :primary, custom_id: "coll_prev_#{page}_#{event.user.id}")
        row.button(label: '▶️', style: :primary, custom_id: "coll_next_#{page}_#{event.user.id}")
      end
    end

    event.respond(embeds: [embed], components: components)
  end
end