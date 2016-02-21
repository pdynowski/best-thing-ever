require 'rails_helper'

feature 'user visits artists#show' do
  scenario "user should see a list of that user's profile page" do
    visit '/sessions/new'
    fill_in "Email", :with => "test@test.com"
    fill_in "Password", :with => "test"
    click_button "Login"
    visit 'users/1'
    expect(page).to have_content('Profile')
  end

  scenario "user should see a list of that user's top artists" do
    visit '/sessions/new'
    fill_in "Email", :with => "test@test.com"
    fill_in "Password", :with => "test"
    click_button "Login"
    visit 'users/1'
    expect(page).to have_selector('.artist-row', count: 40)    
  end

  scenario "user should see a list of that user's groups" do
    visit '/sessions/new'
    fill_in "Email", :with => "test@test.com"
    fill_in "Password", :with => "test"
    click_button "Login"
    visit 'users/1'
    expect(page).to have_content('Groups')    
  end

end