# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tags_hash do
    item nil
    hash "MyString"
    relevance 1
  end
end
