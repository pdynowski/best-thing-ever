class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to group_show_path(group)
    else
      render 'groups/'
    end
  end

  private 

    def comment_params
      params.require(:comment).permit(:content)
    end

end