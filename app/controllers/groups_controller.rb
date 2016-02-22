class GroupsController < ApplicationController

  def index
    @groups = Group.all
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
        [artist_obj.name, artist[1]]
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

