class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @books = Book.all
    respond_to do |format|
      format.html
      format.js
    end
    # render json: @books
  end

  def show
    @comment = @book.comments.build
    @comments = @book.comments
  end

  def new
    if params[:back]
      @book = Book.new(books_params)
    else
      @book = Book.new
    end
  end

  def edit
  end

  def update
    if @book.update(books_params)
      redirect_to books_path, notice: "トピックを更新しました！"
    else
      render "edit"
    end
  end

  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to books_path, notice: "トピックを作成しました！"
      NoticeMailer.sendmail_book(@book).deliver
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
    params.require(:book).permit(:title, :content, :image)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
