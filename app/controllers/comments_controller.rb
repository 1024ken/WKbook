class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @book = @comment.book
    respond_to do |format|
      if @comment.save
        format.html { redirect_to book_path(@book), notice: 'コメントを投稿しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @book = @comment.book
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to books_path, notice: "コメントを更新しました！"
    else
      render "edit"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      if @comment.destroy
        format.html{ redirect_to book_path(@book), notice: 'コメントを削除しました。'}
        format.js{ render :index }
      else
        format.html{ render :index }
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:book_id, :content)
  end
end
