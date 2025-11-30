FactoryBot.define do
  factory :account do
    name { "Visa Credit Card" }
    description { "My Credit Card" }
    account_type { "liability" }
    balance { 0.0 }
  end
end
