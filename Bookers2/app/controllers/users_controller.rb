class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    if @user.save
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render action: :show
    end
  end

  def index
    @users = User.all
    @user_current = current_user
    @books = @user_current.books
    @book_new = Book.new
    @following_users = current_user.following_user
    @follower_users = current_user.follower_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @following_users = current_user.following_user
    @follower_users = current_user.follower_user
    @user_current = current_user
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    render action: :edit
    else
    @user = current_user
    @books = @user.books
    @book = Book.new
    redirect_to user_path(@user.id)
    end
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render action: :edit
    end
  end

  def follower
    user = User.find(params[:user_id])
    @following_users = user.following_user
  end

  def followed
    user = User.find(params[:user_id])
    @follower_users = user.follower_user
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end