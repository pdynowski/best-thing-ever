class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:login_error] = user.errors.full_messages.to_sentence
      render :new
    end
  end

  def new
  end

  def destroy
    session[:user_id].destroy
    redirect_to root_url
  end
end
