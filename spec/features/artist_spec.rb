require 'rails_helper'

feature 'user visits artists#index' do
  scenario 'user should see a list of top artists' do
    visit 'artists/index'
    expect(page.find('.artist_score').length).to eq 40
  end
end
