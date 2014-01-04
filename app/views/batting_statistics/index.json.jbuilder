json.array!(@batting_statistics) do |batting_statistic|
  json.extract! batting_statistic, :id, :player_id, :year, :team, :games_played, :at_bats, :runs_scored, :hits, :doubles, :triples, :home_runs, :runs_batted_in, :stolen_bases, :caught_stealing
  json.url batting_statistic_url(batting_statistic, format: :json)
end
