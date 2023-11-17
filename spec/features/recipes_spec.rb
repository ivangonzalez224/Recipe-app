require 'rails_helper'

RSpec.describe 'recipes path', type: :feature do
  it 'displays the correct content when visits recipes without sign in' do
    visit recipes_path

    expect(page).to have_content('You need to sign in or sign up before continuing')
  end

  it 'displays the correct selector when visits recipes without sign in' do
    visit recipes_path

    expect(page).to have_selector('input.post-add-btn')
  end

  it 'displays the public recipes when visits public recipes without sign in' do
    visit root_path

    expect(page).to have_content('Welcome to Recipes.com!')
  end
end
