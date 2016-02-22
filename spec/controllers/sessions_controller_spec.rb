require 'rails_helper'

describe SessionsController do
  describe 'GET #new' do
    it 'renders a new login form' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:user) { User.create!(username: 'panda', email: 'panda@bear.com', password: 'bamboo') }

    it 'should create a user_id in the sessions hash' do
      @request.session[:user_id] = User.last.id
    end

    it 'should flash an error if login was unsuccesful' do

      post :create,  params = {session: {email: 'wrong', password: 'wrong'}}
      controller.flash[:login_error] = "Login was incorrect."
      expect(controller).to set_flash
      expect(response).to render_template(:new)

    end
  end

  describe 'POST #destroy' do
    it 'should delete the session on logout and go to the index page' do
      controller.session[:user_id] = User.last.id
      post :destroy, { id: User.last.id }
      expect(response).to redirect_to('/')
    end
  end
end
