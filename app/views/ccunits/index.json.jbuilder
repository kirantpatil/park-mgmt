json.array!(@ccunits) do |ccunit|
  json.extract! ccunit, :id, :ip, :port, :floor_id
  json.url ccunit_url(ccunit, format: :json)
end
