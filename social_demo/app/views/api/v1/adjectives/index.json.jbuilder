json.array!(@adjectives) do |adjective|
  json.extract! adjective, :id, :name
end
