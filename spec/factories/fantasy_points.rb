
FactoryGirl.define do
  factory :fantasy_point do
    home_run { rand(1..10) }
    rbi { rand(1..10) }
    stolen_base { rand(1..10) }
    caught_stealing { rand(1..10) }
  end
end
