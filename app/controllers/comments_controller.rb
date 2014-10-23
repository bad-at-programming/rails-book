class CommentsController < ApplicationController

  before_filter :set_headers

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
  end

  def update

  end

  def show
    @comments = Comment.where(post_id: params[:id])
    respond_to do |format|
      format.json { render :json => @comments.to_json } 
      format.xml  { render :xml  => @comments.to_xml  }
    end
  end

private
  def comment_params
    params.require(:comment).permit(:name, :email, :body, :post_id)
  end
  
  def set_headers
    headers['Access-Control-Allow-Origin'] = "http://mdever.github.io"
  end
end
