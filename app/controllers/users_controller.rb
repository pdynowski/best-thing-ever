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
    @groups = @user.groups
    @votes = @user.votes
    artists_scores = Artist.score(@votes)
    scores_sort = artists_scores.sort_by do |key, value|
      value
    end
    artists = scores_sort.reverse.shift(40)
    artist_ranks = Artist.ranking(artists_scores)
    @user_artists = artists.map do |artist|
      artist_obj = Artist.find(artist[0])
      [artist_ranks[artist[0]], artist_obj.name, artist[1]]
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
    User.find(session[:user_id]).destroy
    reset_session
    redirect_to "/"
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

end
