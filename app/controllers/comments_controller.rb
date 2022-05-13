# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment.commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      case @comment.commentable_type
      when 'Book'
        @book = @comment.commentable
        render 'books/show'
      when 'Report'
        @report = @comment.commentable
        render 'reports/show'
      end
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @comment.try(:destroy)

    redirect_to @comment.commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    permit_params = params.require(:comment).permit(:content, :commentable_id, :commentable_type)
    permit_params[:user_id] = current_user.id

    permit_params
  end
end
