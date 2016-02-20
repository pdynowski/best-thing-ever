require 'rails_helper'

describe UsersController do
  let!(:user) { User.create!(username: 'Papa', email: 'papa@papa.com', password: 'papa') }
  describe 'GET #index' do
    it 'shows a list of all users' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'renders a new user template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it 'should create a new user' do
      params = { user: {
                  username: 'Test',
                  email: 'test@test.com',
                  password: 'password'
                }
              }
    should permit(:username, :email, :password).
      for(:create, params: params).
        on(:user)
    end
  end

  describe 'GET #show' do
    it 'should render a users page' do
      get :show, {id: User.last.id}
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #update' do
    context  "when input is valid" do
      def valid_params
        { username: "Kendrick Lamar", email:"topimp@butterf.ly", password:"obamasaywhatitdo" }
      end

      it "redirects to user's profile" do
        post :update, { id: User.last.id, user: valid_params }
         expect(response).to redirect_to(user_path(User.last.id))
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the users edit form' do
      get :edit, { id: User.last.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #destroy' do
    it 'destroys a user and renders a new user page' do
      session[:user_id] = User.last.id
      post :destroy, { id: User.last.id}
      expect(response).to render_template(:new)
    end
  end

end
