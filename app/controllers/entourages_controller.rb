class EntouragesController < ApplicationController

  def new
    @entourage = Entourage.new
    @group_id = flash[:group_id]
  end

  def create
    entourage = Entourage.new(entourage_params, user_id: session[:user_id])

  end


  private

  def entourage_params
    params.require(:entourage).permit(:user_id, :group_id)
  end

end
