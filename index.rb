require "discordrb"
require "dotenv/load"
require "colorize"
require_relative "src/utils/logger"
require 'json'

DATA_FILE = File.join(__dir__, 'data.json')

if File.exist?(DATA_FILE)
    file_content = File.read(DATA_FILE)
    begin
        $data = JSON.parse(file_content)
    rescue JSON::ParserError
        $data = {}
        puts "[WARNING] data.json could not be parsed. Starting with empty data."
    end
    else
    $data = {}
    puts "[INFO] data.json not found. Starting with empty data."
end

class ExtendedClient < Discordrb::Bot 
    attr_reader :commands, :buttons, :menus, :modals

    # Initiate the client
    def initialize

        # Check if there are no environmental variables setup
        if ENV["CLIENT_TOKEN"].nil? || ENV["CLIENT_ID"].nil?
            Logger.notification(LogType::WARNING, "Environmental Variables have not been set correctly in the .env file!")
            exit 1
        end

        # Prepare the discord client
        super(
            token: ENV["CLIENT_TOKEN"],
            client_id: ENV["CLIENT_ID"],
            intents: :all,
            log_mode: :error
        )

        # Define all the modules
        @commands = {}
        @buttons = {}
        @menus = {}
        @modals = {}
    end

    # Handler to load all the modules
    def loadModules()
        totalModules = 0
        
        # Build the path to the src folder
        srcPath = File.join(__dir__, "src").tr("\\", "/")

        # Create a search pattern for specific modules
        files = Dir.glob(File.join(srcPath, "{commands,events,interactions}/**/*.rb"))

        # Check if there are no files => exit the process
        if files.empty?
            Logger.notification(LogType::CRITICAL, "No files were found in the specified modules.")
            exit 1
        end

        # Loop through each file
        files.each do |file|
            begin

                # Format the file to remove back-slashing (windows)
                formattedFile = file.tr("\\", "/")

                # Load the file for saving
                load formattedFile

                # Format the file to match the classname
                className = File.basename(formattedFile, ".rb").split('_').map(&:capitalize).join

                # If the classname matches => Create a new instance of the class & save it
                if Object.const_defined?(className)                                
                    component = Object.const_get(className).new
                else

                    # If no class was found => skip it
                    next
                end

                # Build the path from src path to the imported class
                relativePath = formattedFile.sub("#{srcPath}/", "").split("/")

                # Determine which category the class is in
                category = relativePath.find{ |dir| ["interactions", "commands", "events"].include?(dir) }

                # Handler for the category
                case category
                    when "commands"
                        if component.respond_to?(:name) && component.name
                            @commands[component.name] = component
                            totalModules += 1
                        end
                    when "interactions"
                        subModule = relativePath.find{ |int| ["buttons", "menus", "modals"].include?(int) }
                        instance_variable_get("@#{subModule}")[component.name] = component
                        totalModules += 1
                    when "events"
                        component.execute(self)
                        totalModules += 1
                end
            rescue => error
                Logger.error("Failed to load #{file}", error)
            end
        end
        Logger.notification(LogType::SYSTEM, "Loaded #{totalModules} modules.")
    end

    def handleInteractions()

        # Listener for when an interaction was created
        self.interaction_create do |event|

            # Determine the nme of the interaction
            name = event.interaction.data ? event.interaction.data["name"] : nil
            command = @commands[name.to_s]

            case event.interaction.type

            # Handle slash command executions
            when 2
                if command
                    begin
                        command.execute(event)
                    rescue => error
                        Logger.error("Command Execution Failed", error)
                        event.respond(content: "An error occurred.", ephemeral: true)
                    end
                end

            # Handle autocompletion typing
            when 4
                if command && command.respond_to?(:handle_autocomplete)
                    command.handle_autocomplete(event)
                end
            end
        end

        # Button Listener
        self.button(nil) do |event|
            handler = @buttons[event.custom_id] || @buttons.values.find { |button| event.custom_id.start_with?(button.name) }
            handler&.execute(event)
        end

        # Menu listener
        self.select_menu(nil) do |event|
            @menus[event.custom_id]&.execute(event)
        end

        # Modal Listener
        self.modal_submit(nil) do |event|
            @modals[event.custom_id]&.execute(event)
        end
    end

    # Handler for handling command registration
    def registerCommands()
        payload = @commands.map do |name, cmd|
            # Build the base command structure
            data = {
                name: name,
                description: cmd.description || "No description",
                type: 1
            }

            # Add options if the command object has them
            if cmd.respond_to?(:options) && cmd.options
                data[:options] = cmd.options.map do |opt|
                    {
                        name: opt[:name],
                        description: opt[:description],
                        type: opt[:type],
                        required: opt[:required] || false,
                        autocomplete: opt[:autocomplete] || false
                    }
                end
            end

            # Return the data to be used in the payload
            data
        end


        Discordrb::API::Application.bulk_overwrite_guild_commands(
            self.token,
            ENV["CLIENT_ID"],

            # The Moonlight Palace Guild ID
            "1438793172422623314",
            payload
        )

        # This is here to hard reset the bots cache if commands aren't showing up correctly
        # Discordrb::API::Application.bulk_overwrite_global_commands(
        #     self.token,
        #     ENV["CLIENT_ID"],
        #     []
        # )

        Logger.notification(LogType::SYSTEM, "Bulk-registered #{@commands.size} commands.")
    end
end

client = ExtendedClient.new
client.loadModules
client.handleInteractions

# Check if the registration flag was added
if ARGV.include?("--r")
    client.registerCommands
else
    Logger.notification(LogType::SYSTEM, "Running without registration. (Use --r to update command attributes/options)");
end
client.run