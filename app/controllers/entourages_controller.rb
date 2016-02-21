class EntouragesController < ApplicationController

  def new
    @entourage = Entourage.new
    @group_id = flash[:group_id]
  end

  def create
    group = Group.find(params[:entourage][:group_id])
    if group && group.authenticate(params[:entourage][:password])
      entourage = Entourage.new(entourage_params)
      if entourage.save
        redirect_to group_path(group)
      else
        flash[:group_join_errors] = group.errors.full_messages
        @entourage = Entourage.new
        @group_id = group.id
        render :new
      end
    else
      flash[:group_join_errors] = "Invalid group id or password"
      @entourage = Entourage.new
      @group_id = group.id
      render :new
    end
  end


  private

  def entourage_params
    ent_params = params.require(:entourage).permit(:user_id, :group_id, :password).except(:password)
    ent_params[:user_id] = session[:user_id]
    ent_params
  end

end
