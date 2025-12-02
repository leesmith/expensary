# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Category.find_or_create_by!(group_title: "Income", title: "Credit Card Rewards")
Category.find_or_create_by!(group_title: "Income", title: "Interest")
Category.find_or_create_by!(group_title: "Income", title: "Paycheck")

Category.find_or_create_by!(group_title: "Bills", title: "Gas")
Category.find_or_create_by!(group_title: "Bills", title: "Internet")
Category.find_or_create_by!(group_title: "Bills", title: "Phone")
Category.find_or_create_by!(group_title: "Bills", title: "Power")
Category.find_or_create_by!(group_title: "Bills", title: "Television")
Category.find_or_create_by!(group_title: "Bills", title: "Water")

Category.find_or_create_by!(group_title: "Discretionary", title: "Charity")
Category.find_or_create_by!(group_title: "Discretionary", title: "Entertainment")
Category.find_or_create_by!(group_title: "Discretionary", title: "Fast Food")
Category.find_or_create_by!(group_title: "Discretionary", title: "Gifts")
Category.find_or_create_by!(group_title: "Discretionary", title: "Restaurants")
Category.find_or_create_by!(group_title: "Discretionary", title: "Shopping")
Category.find_or_create_by!(group_title: "Discretionary", title: "Subscriptions")

Category.find_or_create_by!(group_title: "Living", title: "Auto Insurance")
Category.find_or_create_by!(group_title: "Living", title: "Auto Maintenance")
Category.find_or_create_by!(group_title: "Living", title: "Doctor")
Category.find_or_create_by!(group_title: "Living", title: "Fuel")
Category.find_or_create_by!(group_title: "Living", title: "Groceries")
Category.find_or_create_by!(group_title: "Living", title: "Health Insurance")
Category.find_or_create_by!(group_title: "Living", title: "Life Insurance")
Category.find_or_create_by!(group_title: "Living", title: "Medicine")
Category.find_or_create_by!(group_title: "Living", title: "Mortgage")
Category.find_or_create_by!(group_title: "Living", title: "Pets")

Category.find_or_create_by!(group_title: "Savings", title: "Emergency Fund")
