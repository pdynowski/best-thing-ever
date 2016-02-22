require 'rails_helper'

# feature 'user visits groups#index' do
#   scenario 'user should see a link to create a new group' do
#     visit 'groups/'
#   end
# end

feature 'user tries to create a new group' do
  before(:each) do
    visit '/sessions/new'
    fill_in "Email", :with => "test@test.com"
    fill_in "Password", :with => "test"
    click_button "Login"
  end
  scenario 'user should see a form to create a group' do
    visit 'groups/new'
    expect(page).to have_selector('.new-group-form')
  end

  scenario 'form should have a name field' do
    visit 'groups/new'
    expect(page.find('.new-group-form')).to have_field("Your awesome band name:")
  end

  scenario 'form should have a password field' do
    visit 'groups/new'
    expect(page.find('.new-group-form')).to have_field("Band Access Key:")
  end

end


