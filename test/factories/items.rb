FactoryGirl.define do
  factory :item do
    seller

    description Faker::Lorem.sentences
  end
end
