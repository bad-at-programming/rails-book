class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     :only=>:destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params) 
    if @user.save
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_to @user
    else
      render 'new'
    end    
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit' # Renders edit page with addition errors displayed
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

   
  # Returns an array of Users whom the @user is following. Corresponds to the /users/:id/following route and renders users/following.html.erb
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate( page: params[:page] )
    render 'show_follow'
  end

  # Returns an array of Users whom are following the @user. Corresponds to the /user/:id/followers route and renders user/followers.html.erb
  def followers
    @title = "Followers"
    @user = User.find( params[:id] )
    @users = @user.followers.paginate( page: params[:page] )
    render 'show_follow'
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # Before filters
    
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
       redirect_to(root_url) unless current_user.admin?
    end
end
