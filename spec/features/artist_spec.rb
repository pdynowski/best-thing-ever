require 'rails_helper'

feature 'user visits artists#index' do
  scenario 'user should see a list of top artists' do
    visit 'artists/'
    expect(page).to have_selector('.artist-row', count: 40)
  end
end
