def register_ready_cleanup(bot)
  bot.ready do |_event|
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
end
