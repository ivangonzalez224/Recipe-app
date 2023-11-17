require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'validations' do
    let(:user) { User.new(name: 'Kobe') }

    it 'is valid with valid attributes' do
      recipe = Recipe.new(user: user, name: 'Apple Pie', preparation_time: 30, cooking_time: 60, description: 'A delicious apple pie', public: true)
      expect(recipe).to be_valid
    end

    it 'is not valid without a name' do
      recipe = Recipe.new(user: user, preparation_time: 30, cooking_time: 60, description: 'A delicious apple pie', public: true)
      expect(recipe).to_not be_valid
    end

    it 'is not valid with a negative preparation time' do
      recipe = Recipe.new(user: user, name: 'Apple Pie', preparation_time: -30, cooking_time: 60, description: 'A delicious apple pie', public: true)
      expect(recipe).to_not be_valid
    end

    it 'is not valid with a negative cooking time' do
      recipe = Recipe.new(user: user, name: 'Apple Pie', preparation_time: 30, cooking_time: -60, description: 'A delicious apple pie', public: true)
      expect(recipe).to_not be_valid
    end
  end

end
