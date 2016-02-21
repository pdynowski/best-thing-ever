require 'rails_helper'

describe User do
  it { should validate_presence_of :username }
  it { should validate_presence_of :email }
  it { should have_secure_password }
  it { should have_many(:votes) }
  it { should have_many(:entourages) }
  it { should have_many(:groups) }
end
