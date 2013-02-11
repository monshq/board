FactoryGirl.define do
  factory :item do
    seller

    description Faker::Lorem.sentence
    contact_info Faker::Lorem.sentence
  end

  factory :published_item, parent: :item do
    state :published
  end
end
