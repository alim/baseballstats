# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :batting_statistic do
    player_id ""
    year ""
    team ""
    games_played ""
    at_bats ""
    runs_scored ""
    hits ""
    doubles ""
    triples ""
    home_runs ""
    runs_batted_in ""
    stolen_bases ""
    caught_stealing ""
  end
end
