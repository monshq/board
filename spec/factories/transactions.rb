# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    user nil
    item nil
    amount 1.5
    status "MyString"
  end
end
