json.array!(@fantasy_points) do |fantasy_point|
  json.extract! fantasy_point, :id, :home_run, :rbi, :stolen_base, :caught_stealing
  json.url fantasy_point_url(fantasy_point, format: :json)
end
