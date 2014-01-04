json.array!(@players) do |player|
  json.extract! player, :id, :player_id, :birth_year, :first_name, :last_name
  json.url player_url(player, format: :json)
end
