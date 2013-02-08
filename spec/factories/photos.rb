FactoryGirl.define do
  factory :photo do
    item

    file {Faker::Lorem.sentence.tr(' ','/')}
  end
end
