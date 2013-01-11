FactoryGirl.define do
  factory :message do
    sender
    recipient
    item

    text Faker::Lorem.sentence
  end
end
