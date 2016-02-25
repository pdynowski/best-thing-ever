class CommentsController < ApplicationController

  def create
    if session[:user_id].to_s == params[:comment][:user_id].to_s
    @comment = Comment.new(comment_params)
      if @comment.save
        redirect_to group_path(@comment.group_id)
      else
        render 'groups/show'
      end
    else
      render 'votes/vote_hack'
    end
  end

  private 

    def comment_params
      com_para = params.require(:comment).permit(:content, :group_id, :user_id)
      com_para
    end

end