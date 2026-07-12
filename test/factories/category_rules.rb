FactoryBot.define do
  factory :category_rule do
    category
    description { "Groceries" }
    amount { 50.0 }
    amount_operator { "eq" }
  end
end
