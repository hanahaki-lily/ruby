def register_member_leave(bot)
  bot.member_leave do |event|
    server_id = event.server.id.to_s
    user_id   = event.user.id.to_s

    next unless $data[server_id]

    if $data[server_id].delete(user_id)
      save_data($data)
      puts "🧹 Removed user #{user_id} from server #{server_id}"
    end
  end
end
