json.array!(@floors) do |floor|
  json.extract! floor, :id, :name, :image_url
  json.url floor_url(floor, format: :json)
end
