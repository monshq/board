# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    item
    user
    amount { sprintf('%#0.2f', rand(0.00..1000.00)).to_f }
  end
end
