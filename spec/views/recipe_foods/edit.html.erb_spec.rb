require 'rails_helper'

RSpec.describe 'recipe_foods/edit', type: :view do
  let(:recipe_food) do
    RecipeFood.create!
  end

  before(:each) do
    assign(:recipe_food, recipe_food)
  end

  it 'renders the edit recipe_food form' do
    render
  end
end
