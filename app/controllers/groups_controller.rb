class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    if group.save
      redirect_to group_path(group)
    else
      flash[:group_create_error] = group.errors.full_messages
      render :new
    end
  end

  def show

  end


  private
  def group_params
    params.require(:group).permit(:name, :password)
  end

end

