# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Category.find_or_create_by!(group_title: "Bills", title: "Power")
Category.find_or_create_by!(group_title: "Bills", title: "Phone")
Category.find_or_create_by!(group_title: "Bills", title: "Water")
Category.find_or_create_by!(group_title: "Bills", title: "Gas")
Category.find_or_create_by!(group_title: "Bills", title: "Internet")
Category.find_or_create_by!(group_title: "Bills", title: "Lawn & Pest")
Category.find_or_create_by!(group_title: "Bills", title: "Television")

Category.find_or_create_by!(group_title: "Discretionary", title: "Restaurants")
Category.find_or_create_by!(group_title: "Discretionary", title: "Fast food")
Category.find_or_create_by!(group_title: "Discretionary", title: "Alcohol")
Category.find_or_create_by!(group_title: "Discretionary", title: "Home Improvements")
Category.find_or_create_by!(group_title: "Discretionary", title: "Subscriptions")
Category.find_or_create_by!(group_title: "Discretionary", title: "Travel")
Category.find_or_create_by!(group_title: "Discretionary", title: "Shopping")
Category.find_or_create_by!(group_title: "Discretionary", title: "Entertainment")
Category.find_or_create_by!(group_title: "Discretionary", title: "Golf")
Category.find_or_create_by!(group_title: "Discretionary", title: "Gifts")
Category.find_or_create_by!(group_title: "Discretionary", title: "Charity")

Category.find_or_create_by!(group_title: "Kids", title: "Cade Extracurriculars")
Category.find_or_create_by!(group_title: "Kids", title: "Cade Clothing")
Category.find_or_create_by!(group_title: "Kids", title: "Cade Doctor")
Category.find_or_create_by!(group_title: "Kids", title: "Cade meds")
Category.find_or_create_by!(group_title: "Kids", title: "College 529")

Category.find_or_create_by!(group_title: "Living", title: "Auto maintenance")
Category.find_or_create_by!(group_title: "Living", title: "Auto insurance")
Category.find_or_create_by!(group_title: "Living", title: "Auto tag")
Category.find_or_create_by!(group_title: "Living", title: "Fuel")
Category.find_or_create_by!(group_title: "Living", title: "Parking")
Category.find_or_create_by!(group_title: "Living", title: "Rideshare")
Category.find_or_create_by!(group_title: "Living", title: "Groceries")
Category.find_or_create_by!(group_title: "Living", title: "Doctor")
Category.find_or_create_by!(group_title: "Living", title: "Health Insurance")
Category.find_or_create_by!(group_title: "Living", title: "Mortgage")
Category.find_or_create_by!(group_title: "Living", title: "Home Insurance")
Category.find_or_create_by!(group_title: "Living", title: "Life Insurance")
Category.find_or_create_by!(group_title: "Living", title: "Child Support")
Category.find_or_create_by!(group_title: "Living", title: "Veterinary & Pets")
Category.find_or_create_by!(group_title: "Living", title: "Taxes")
Category.find_or_create_by!(group_title: "Living", title: "Tax prep")
Category.find_or_create_by!(group_title: "Living", title: "Hair")
Category.find_or_create_by!(group_title: "Living", title: "Legal services")
Category.find_or_create_by!(group_title: "Living", title: "Fees")

Category.find_or_create_by!(group_title: "Income", title: "Paycheck")
Category.find_or_create_by!(group_title: "Income", title: "Freelance")
Category.find_or_create_by!(group_title: "Income", title: "Tax return")
Category.find_or_create_by!(group_title: "Income", title: "Interest & Rewards")
