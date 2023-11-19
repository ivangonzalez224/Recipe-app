# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create User1
user1 = User.create!(
  name: 'user1',
  email: 'user1@example.com',
  password: 'password123'
)

# Create User2
user2 = User.create!(
  name: 'user2',
  email: 'user2@example.com',
  password: 'password123'
)

# Create User3
user3 = User.create!(
  name: 'user3',
  email: 'user3@example.com',
  password: 'password123'
)

puts 'Example users created successfully.'