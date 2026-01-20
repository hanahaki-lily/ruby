class Ping
    attr_reader :name, :description

    def initialize
        @name = "ping"
        @description = "Replies with pong latency"
    end

    def execute(event)
        event.respond(
            content: "🏓 Pong! (vee is cool)!",
            components: [
                {
                    type: 1,
                    components: [
                        {
                            type: 2,
                            label: "Is she really?",
                            style: 3,
                            custom_id: "hello"
                        }
                    ]
                }
            ]
        )
    end
end