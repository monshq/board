FactoryGirl.define do
  factory :item do
    seller

    description Faker::Lorem.sentences
    contact_info Faker::Lorem.words
  end
end
