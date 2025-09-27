FactoryBot.define do
  factory :transaction do
    account
    description { "ABC Beverages" }
    amount { 55.00 }
    tran_date { Date.today - 1.week }
  end
end
