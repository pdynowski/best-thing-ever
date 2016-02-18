require 'rails_helper'

feature 'User voting on a faceoff' do
  scenario 'when user visits page' do
    visit '/'
    expect(page).to have_content('Best Thing Ever')
  end

  scenario 'when user looks for artists on homepage' do
    visit '/'
    expect(page).to have_selector('#option1>img')
    expect(page).to have_selector('#option2>img')
  end

  scenario 'when user visits homepage, they see a navbar' do
    visit '/'
    expect(page).to have_selector('.main-nav')
    expect(page).to have_content('Top Scores')
  end

end
