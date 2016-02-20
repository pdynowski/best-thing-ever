require 'rails_helper'

feature 'User voting on a faceoff' do
  scenario 'when user visits page' do
    visit '/'
    expect(page).to have_content('Best Thing Ever')
  end

  scenario 'when user looks for artists on homepage' do
    visit '/'
    expect(page).to have_selector('.option1-vote')
    expect(page).to have_selector('.option2-vote')
  end

  scenario 'when user visits homepage, they see a navbar' do
    visit '/'
    expect(page).to have_selector('.pure-menu')
    expect(page).to have_content('Top Scores')
  end

  scenario 'when user visits homepage, they see a vote link for artist 1' do
    visit '/'
    expect(page).to have_selector('.option1-vote')
  end

  scenario 'when user visits homepage, they see a vote link for artist 2' do
    visit '/'
    expect(page).to have_selector('.option2-vote')
  end

  scenario 'when users visits homepage for the first time, they do not see previous scores' do
    visit '/'
    expect(page).to_not have_selector('.prev-winner')
    expect(page).to_not have_selector('.prev-loser')
  end

  scenario 'when user clicks on artist1, it creates a vote
    with artist1 as winner and artist2 as loser' do
    visit '/'
    allow_any_instance_of(Vote).to receive(:winner_id).and_return(1)
    allow_any_instance_of(Vote).to receive(:loser_id).and_return(2)
    expect { find('.option1-vote').click }.to change(Vote, :count).by(1)
    expect(Vote.last.winner_id).to eq (1)
    expect(Vote.last.loser_id).to eq (2)
    expect(page).to have_selector('.prev-winner')
    expect(page).to have_selector('.prev-loser')
  end

  scenario 'when user clicks on artist2, it creates a vote
    with artist1 as winner and artist1 as loser' do
    visit '/'
    expect { find('.option2-vote').click }.to change(Vote, :count).by(1)
  end

end
