require 'rails_helper'

describe Vote do
  it { should validate_presence_of :winner_id }
  it { should validate_presence_of :loser_id }
  it { should belong_to(:winner).class_name('Artist') }
  it { should belong_to(:loser).class_name('Artist') }
end
