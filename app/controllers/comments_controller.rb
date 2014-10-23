class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
  end

  def update

  end

  def show
    @comments = Comment.where(post_id: params[:id])
    respond_to do |format|
      format.json { render :json => @comments.to_json } 
    end
  end

private
  def comment_params
    params.require(:comment).permit(:name, :email, :body, :post_id)
  end
end
