class Color
  attr_reader :name, :description, :options

  ALLOWED_COLORS = [
    "RoseQuartz", "Amethyst", "Malachite", "Sapphire", "Ruby",
    "Aquamarine", "Diamond", "Onyx", "Amber", "Jade"
  ].freeze

  def initialize
    @name = "color"
    @description = "Change your name color by picking a gem role."
    @options = [
            {
                name: "name",
                description: "The name of the gem color you want",
                type: 3,
                required: true,
                autocomplete: true 
            }
        ]
  end

  def execute(event)
    # Extract the 'name' option from the interaction data
    options = event.interaction.data["options"]
    name_option = options&.find { |opt| opt["name"] == "name" }
    color_input = name_option&.[]("value")&.downcase

    # Find the role in the server
    role = event.server.roles.find { |r| r.name.downcase == color_input }

    if role && ALLOWED_COLORS.map(&:downcase).include?(role.name.downcase)
      begin
        # Identify and remove any existing gem roles the user has
        old_roles = event.user.roles.select { |r| ALLOWED_COLORS.map(&:downcase).include?(r.name.downcase) }
        event.user.remove_role(old_roles) unless old_roles.empty?
        
        # Add the new gem role
        event.user.add_role(role)
        event.respond(content: "🎀 Your color is now **#{role.name}**!")
      rescue => e
        event.respond(content: "⚠️ Role update failed. Ensure my role is higher than the color roles in server settings.", ephemeral: true)
      end
    else
      event.respond(content: "❌ Invalid selection. Please pick a color from the autocomplete menu.", ephemeral: true)
    end
  end

  def handle_autocomplete(event)

    # Fetch what the user has already typed
    value = event.interaction.data["options"].first[1].downcase

    # Attempt to match the what the user has typed
    matches = ALLOWED_COLORS.select { |color| color.downcase.include?(value) }
    
    # Construct 25 choices (discord limit)
    choices = matches.first(25).map { |c| { name: c, value: c } }

    # Show the choices to the user
    event.interaction.show_autocomplete_choices(choices)
  end
end