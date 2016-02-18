require 'rails_helper'

describe VotesController do

  describe "GET #new" do
    it "assigns an option as @option1" do
      get(:new)
      expect(assigns(:option1)).to be_an(Artist)
    end

    it "assigns an option as @option2" do
      get(:new)
      expect(assigns(:option2)).to be_a(Artist)
    end

    it "creates a new instance of Vote" do
      get(:new)
      expect(assigns(:vote)).to be_a_new(Vote)
    end
  end

end
