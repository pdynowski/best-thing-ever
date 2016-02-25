require 'rails_helper'

describe Group do
  it { should validate_presence_of :name }
  it { should have_many(:entourages) }
  it { should have_many(:users) }
  it { should have_secure_password }
  it { should have_many(:comments)}

end
