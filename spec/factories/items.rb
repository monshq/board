FactoryGirl.define do
  factory :item do
    seller

    description Faker::Lorem.sentence
    contact_info Faker::Lorem.sentence
    price 1234.45 #sprintf('%#0.2f', rand(0.00..1000.00)).to_f
  end

  factory :published_item, parent: :item do
    state :published
  end
