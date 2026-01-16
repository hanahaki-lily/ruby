require 'json'

def load_data
  File.exist?('data.json') ? JSON.parse(File.read('data.json')) : {}
end

def save_data(data)
  File.write('data.json', JSON.pretty_generate(data))
end

def ensure_user(server_id, user_id)
  $data[server_id] ||= {}
  $data[server_id][user_id] ||= {
    "xp" => 0,
    "level" => 1,
    "gems" => 0,
    "cards" => {},
    "last_daily" => 0
  }
end
