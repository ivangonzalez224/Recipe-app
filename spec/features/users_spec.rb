require 'rails_helper'

RSpec.describe 'new users session', type: :feature do
  it 'displays the correct content when registration' do
    visit new_user_registration_path

    expect(page).to have_content('Sign up')
  end

  it 'displays the correct selector when registration' do
    visit new_user_registration_path

    expect(page).to have_selector('input.input-food')
  end
end  