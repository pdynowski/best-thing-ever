require 'rails_helper'

describe Comment do 
  it { should validate the presence of :content }
  it { should belong_to(:user) }
  it { should belong_to(:group) }

end