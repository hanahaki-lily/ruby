class CollectionNav
  attr_reader :name

  def initialize
    # We use a placeholder name because your index.rb logic 
    # needs to match the custom_id. We'll handle the logic in execute.
    @name = "coll" 
  end

  def execute(event)
    # ID format: coll_direction_currentPage_ownerID
    parts = event.interaction.data["custom_id"].split('_')
    direction = parts[1]
    current_page = parts[2].to_i
    owner_id = parts[3]

    # Security: Only the owner can flip pages
    if event.user.id.to_s != owner_id
      event.respond(content: "This isn't your collection menu!", ephemeral: true)
      return
    end

    user = $data[event.server.id.to_s]&.[](owner_id)
    sorted_cards = user["cards"].sort_by { |name, _| name }
    
    new_page = direction == "next" ? current_page + 1 : current_page - 1
    
    # Boundary checks
    max_pages = (sorted_cards.size / 10.to_f).ceil
    return if new_page < 0 || new_page >= max_pages

    # Update the message
    # Logic remains same as the command but uses event.update_message
    per_page = 10
    page_items = sorted_cards[new_page * per_page, per_page]
    desc = page_items.map { |name, count| "• **#{name}**: x#{count}" }.join("\n")

    unique = sorted_cards.size
    total = sorted_cards.map { |_, count| count }.sum

    event.update_message(
      embeds: [{
        title: "#{event.user.name}'s Collection",
        description: desc,
        color: 0xFFD700,
        footer: { text: "Page #{new_page + 1} of #{max_pages} | Unique: #{unique} | Total: #{total}" }
      }],
      components: Discordrb::Components::View.new do |view|
        view.row do |row|
          row.button(label: '◀️', style: :primary, custom_id: "coll_prev_#{new_page}_#{owner_id}")
          row.button(label: '▶️', style: :primary, custom_id: "coll_next_#{new_page}_#{owner_id}")
        end
      end
    )
  end
end