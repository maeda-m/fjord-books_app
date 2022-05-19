# frozen_string_literal: true

class Books::CommentsController < CommentsController
  private

  def render_show
    @book = @comment.commentable
    render 'books/show'
  end

  def comment_params
    permitted_params = super
    permitted_params.merge(
      commentable_type: 'Book',
      commentable_id: params[:book_id]
    )
  end
end
