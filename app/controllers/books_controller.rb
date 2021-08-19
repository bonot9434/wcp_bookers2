class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :identification, only: [:edit]
  
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
       redirect_to book_path(@book), notice: "You have created book successfully."
    else
       @user = current_user
       @books = Book.all
       render:index
    end
  end

  def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book), notice: "You have updated user successfully."
    else
       render:edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  
  private
  
    def identification
    book = Book.find(params[:id])
      if book.user_id != current_user.id
        redirect_to books_path
      end
    end
  
    def book_params
      params.require(:book).permit(:title, :body)
    end
end
