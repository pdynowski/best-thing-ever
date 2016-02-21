class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:user_create_error] = user.errors.full_messages.to_sentence
      render :new
    end
  end

  def new
  end

  def show
    @user = User.find(params[:id])
    @votes = @user.votes
    artists_scores = Artist.score(@votes)
    scores_sort = artists_scores.sort_by do |key, value|
      value
    end
    artists = scores_sort.reverse.shift(40)
    @user_artists = artists.map do |artist|
      artist_obj = Artist.find(artist[0])
      [artist_obj.name, artist[1]]
    end
    @user_artists
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      redirect_to user_path(user)
    else
      flash[:user_update_error] = user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(session[:user_id])
    if user.destroy
      reset_session
      flash[:user_successful_destroy] = "User account deleted."
      render :new
    else
      flash[:user_error_destroy] = user.errors.full_messages.to_sentence
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

end
