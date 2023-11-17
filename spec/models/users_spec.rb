require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(
      name: 'Kobe',
      email: 'kobe@example.com',
      password: 'kobe123',
      password_confirmation: 'kobe123'
    )
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(
      email: 'kobe@example.com',
      password: 'kobe123',
      password_confirmation: 'kobe1235'
    )
    expect(user).to_not be_valid
  end
end  