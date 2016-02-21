require 'rails_helper'

describe Entourage do
  it {should validate_presence_of(:user_id)}
  it {should validate_presence_of(:group_id)}
  it {should belong_to(:user)}
  it {should belong_to(:group)}
end
