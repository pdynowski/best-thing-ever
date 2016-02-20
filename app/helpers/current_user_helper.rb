module CurrentUserHelper

  def current_user
    current_user ||= User.find(id: session[:user_id])
  end

end
