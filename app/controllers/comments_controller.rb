class CommentsController < ApplicationController

  before_filter :set_headers

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render :json => { status: "success", id: @comment.id }
    else 
      render :json => { status: "error", message: "Could not save post: #{@comment.errors.messages}"
    end
  end

  def update

  end

  def show
    @comments = Comment.where(post_id: params[:id])
    respond_to do |format|
      format.json { render :json => @comments.to_json } 
      format.xml  { render :xml  => @comments.to_xml  }
    end
    
    # Default to rendering JSON
    render :json => @comments.to_json
  end

private
  def comment_params
    params.require(:comment).permit(:name, :email, :body, :post_id)
  end
  
  def set_headers
    headers['Access-Control-Allow-Origin'] = "http://mdever.github.io"
  end
end
