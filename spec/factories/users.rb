FactoryGirl.define do
  factory :user, aliases: [:seller, :sender, :recipient] do
    email    Faker::Internet.email
    password Faker::Lorem.sentence
  end
end
