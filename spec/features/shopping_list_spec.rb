require 'rails_helper'

RSpec.describe 'ShoppingList', type: :feature do
  it 'displays the correct content when visits shopping list without sign in' do
    visit shopping_list_path

    expect(page).to have_content('You need to sign in or sign up before continuing')
  end

  it 'displays the correct selector when visits shopping list without sign in' do
    visit shopping_list_path

    expect(page).to have_selector('input.post-add-btn')
  end
end
