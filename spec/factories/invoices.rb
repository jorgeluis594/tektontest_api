FactoryBot.define do
  factory :invoice do
    client { Faker::Music::PearlJam.song }
    ruc { Faker::IDNumber.brazilian_citizen_number }
  end
end
