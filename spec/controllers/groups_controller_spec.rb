require 'rails_helper'

describe GroupsController do
  describe 'GET new' do
    it 'renders a new group template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it 'should create a new user group if user is logged in' do
      controller.session[:user_id] = 1
      params = { group: {
          name: 'Foxtato',
          password: 'DoTheThing'
        }
      }
      should permit(:name, :password).
        for(:create, params: params).
          on(:group)
    end
  end

  describe 'GET #show' do
    it "should render the home page for a group" do
      controller.session[:user_id] = 1
      Group.create!(name: 'Foxtato', password: 'DoTheThing')
      Entourage.create!(group_id: Group.last.id, user_id: session[:user_id])
      get :show, {id: Group.last.id}
      expect(response).to render_template(:show)
    end
  end



end
