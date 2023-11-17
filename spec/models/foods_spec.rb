require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'validations' do
    let(:user) { User.new(name: 'Kobe') }

    it 'is valid with valid attributes' do
      food = Food.new(user: user, name: 'Apple', measurement_unit: 'g', price: 3, quantity: 500)
      expect(food).to be_valid
    end
  end  
end    