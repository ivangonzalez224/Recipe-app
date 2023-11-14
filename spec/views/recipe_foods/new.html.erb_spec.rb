require 'rails_helper'

RSpec.describe 'recipe_foods/new', type: :view do
  before(:each) do
    assign(:recipe_food, RecipeFood.new)
  end

  it 'renders new recipe_food form' do
    render
  end
end
