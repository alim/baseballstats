# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :firstname do |n|
    "Babe#{n}"
  end
  
  sequence :lastname do |n|
    "Ruth#{n}"
  end
  
  factory :player do
    player_id { generate(:player) }
    birth_year { rand(1800..1995) }
    first_name { generate(:firstname) }
    last_name { generate(:lastname) }
  end
end
