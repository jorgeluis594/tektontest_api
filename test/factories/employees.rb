FactoryBot.define do
  factory :employee do
    name { Faker::Music::PearlJam.song }
    dni { Faker::IDNumber.brazilian_citizen_number }
    email { Faker::Internet.email }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    position { 1 }
    activated { true }
  end
end