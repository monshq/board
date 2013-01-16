FactoryGirl.define do
  factory :user, aliases: [:seller, :sender, :recipient] do
    email Faker::Internet.email

    p = Faker::Lorem.sentence
    password p
    password_confirmation p

    confirmed_at Time.now
  end
end
