class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :identification, only: [:edit]
  
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all
  end
  
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_path(@user), notice: "You have updated user successfully."
    else
       render:edit
    end
  end
  
  private
    def identification
    user = User.find(params[:id])
      if user != current_user
        redirect_to user_path(current_user)
      end
    end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
