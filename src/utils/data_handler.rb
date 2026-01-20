require 'json'

DATA_FILE = File.join(__dir__, '../../data.json')

def load_data
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
end

def save_data
  File.write(DATA_FILE, JSON.pretty_generate($data))
end
