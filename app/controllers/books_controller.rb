class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy]
  berore_action :authentificate_user!

  def index
    @books = Book.all
  end

  def new
    if params[:back]
      @book = Book.new(books_params)
    else
      @book = Book.new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book = Book.update(params[:id])
      redirect_to books_path, notice: "トピックを更新しました！"
    else
      render "edit"
    end
  end

  def create
    @book = Book.create(books_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to books_path, notice: "トピックを作成しました！"
    else
      render "new"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "トピックを削除しました！"
  end

  def confirm
    @book = Book.new(books_params)
    render :new if @book.invalid?
  end

  private
  def books_params
    params.require(:book).permit(:title, :content)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
