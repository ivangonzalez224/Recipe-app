class AddSeedData < ActiveRecord::Migration[7.1]
  def up
    # Add your seed data creation code here
    User.create!(name: 'user1', email: 'user1@example.com', password: 'password123')
    User.create!(name: 'user2', email: 'user2@example.com', password: 'password123')
    User.create!(name: 'user3', email: 'user3@example.com', password: 'password123')
  end

  def down
    User.destroy_all
  end
end
