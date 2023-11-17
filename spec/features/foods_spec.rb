require 'rails_helper'

RSpec.describe 'foods path', type: :feature do
  it 'displays the correct content when visits foods without sign in' do
    visit foods_path

    expect(page).to have_content('You need to sign in or sign up before continuing')
  end

  it 'displays the correct selector when visits foods without sign in' do
    visit foods_path

    expect(page).to have_selector('input.post-add-btn')
  end
end
