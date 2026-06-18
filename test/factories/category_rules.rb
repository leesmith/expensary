FactoryBot.define do
  factory :category_rule do
    category
    description { "Groceries" }
    amount { 50.0 }
  end
end
