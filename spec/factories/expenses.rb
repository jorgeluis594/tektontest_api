FactoryBot.define do
  factory :expense do
    release_date { Faker::Date.between(from: 2.days.ago, to: Date.today) }
    category { [0,1,2,3].sample() }
    cost { rand(150.99).ceil(2) }
    currency_type { 0 }
    description { Faker::Lorem.paragraph }
  end
end
