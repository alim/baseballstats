# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :player do |n|
    "player#{n}"
  end
  
  factory :batting_statistic do
    player_id { generate(:player) }
    year { rand(1900..1995) }
    team "DET"
    games_played { rand(0..500) }
    at_bats  { rand(0..500) }
    runs_scored  { rand(0..500) }
    hits  { rand(0..500) }
    doubles  { rand(0..500) }
    triples  { rand(0..500) }
    home_runs { rand(0..500) }
    runs_batted_in  { rand(0..500) }
    stolen_bases  { rand(0..500) }
    caught_stealing  { rand(0..500) }
  end
end
