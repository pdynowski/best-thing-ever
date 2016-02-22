class GroupsController < ApplicationController
  before_action :require_login

  def index
    @user_groups = User.find(session[:user_id]).groups
    @groups = Group.all - @user_groups
    @user_groups = @user_groups.sort_by { |group| group.votes.count}.reverse
  end

  def new
    @group = Group.new
  end

  def create
    if session[:user_id]
      group = Group.new(group_params)
      if group.save
        Entourage.create(group_id: group.id, user_id: session[:user_id])
        redirect_to group_path(group)
      else
        flash[:group_create_error] = group.errors.full_messages
        render :new
      end
    else
      flash[:group_create_error] = "You must be logged in to create a group"
      @group = Group.new
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    if @group.users.where(id: session[:user_id]).empty?
      flash[:group_id] = @group.id
      redirect_to new_entourage_path
    else
      @votes = @group.votes
      artists_scores = Artist.score(@votes)
      scores_sort = artists_scores.sort_by do |key, value|
        value
      end
      artists = scores_sort.reverse.shift(40)
      @group_artists = artists.map do |artist|
        artist_obj = Artist.find(artist[0])
        [artist_obj.ranking, artist_obj.name, artist[1]]
      end
      @last_votes =
      @votes.sort{|v1, v2| v2.created_at <=> v1.created_at}.shift(20).map do |vote|
        vote_set = {}
        vote_set[:winner] = Artist.find(vote.winner_id).get_image_url
        vote_set[:winner_name] = Artist.find(vote.winner_id).name
        vote_set[:voter] = vote.user.username
        vote_set[:loser] = Artist.find(vote.loser_id).get_image_url
        vote_set[:loser_name] = Artist.find(vote.loser_id).name
        vote_set
      end
      @group_artists
      render :show
    end
  end


  private
  def group_params
    params.require(:group).permit(:name, :password)
  end

end

