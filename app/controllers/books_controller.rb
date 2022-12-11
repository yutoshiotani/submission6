class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:top]

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    user_id = Book.find(params[:id]).user.id.to_i
  login_user_id = current_user.id
  if(user_id != login_user_id)
    redirect_to books_path
  end
    @book = Book.find(params[:id])
  end

  def update
    user_id = Book.find(params[:id]).user.id.to_i
  login_user_id = current_user.id
  if(user_id != login_user_id)
    redirect_to books_path
  end
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:body,:title)
  end
end
