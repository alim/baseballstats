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
  
  # Factory for creating a batting statistic, where player stats
  # improve with each submission. The player_id, team, and year must be
  # passed into the factory
  sequence :atbats do |n| 
    (400 - n)
  end
  
  sequence :runs do |n| 
    (100 + (n*3))
  end
  
  sequence :newhits do |n| 
    (100 + (n*2))
  end
  
  sequence :newdoubles do |n| 
    (40 + (n*3))
  end
  
  sequence :newtriples do |n| 
    (30 + (n*2))
  end
  
  sequence :newhr do |n| 
    (20 + (n*2))
  end
  
  sequence :newrbi do |n| 
    (100 + (n*3))
  end
  
  sequence :newbases do |n| 
    (50 + (n*2))
  end
  
  sequence :newstealing do |n| 
    if n <= 100
      (100 - n)
    else
      1
    end
  end
  
  factory :batting_improves, class: BattingStatistic do
    games_played { rand(400..2000) }
    at_bats 400
    runs_scored { generate(:runs) }
    hits { generate(:newhits) }
    doubles { generate(:newdoubles) }
    triples { generate(:newtriples) }
    home_runs { generate(:newhr) }
    runs_batted_in { generate(:newrbi) }
    stolen_bases { generate(:newbases) }
    caught_stealing { generate(:newstealing) }
  end
  
  # Factory for creating batting statistics for a given team and year.
  # Team and year need to be passed into the factory.
  factory :team_batting, class: BattingStatistic do
    player_id { generate(:player) }
    games_played { rand(0..500) }
    at_bats { generate(:atbats) }
    runs_scored { generate(:runs) }
    hits { generate(:newhits) }
    doubles { generate(:newdoubles) }
    triples { generate(:newtriples) }
    home_runs { generate(:newhr) }
    runs_batted_in { generate(:newrbi) }
    stolen_bases { generate(:newbases) }
    caught_stealing { generate(:newstealing) }  
  end
end
