require 'json'

# Helper method to save the global $data hash to the DATA_FILE
def save_data
  begin
    # Uses DATA_FILE and $data defined in index.rb
    File.write(DATA_FILE, JSON.pretty_generate($data))
  rescue => e
    puts "[ERROR] Failed to save data.json: #{e.message}"
  end
end