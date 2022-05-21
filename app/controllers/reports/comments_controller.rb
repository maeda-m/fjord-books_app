# frozen_string_literal: true

class Reports::CommentsController < CommentsController
  private

  def render_show
    @report = @comment.commentable
    render 'reports/show'
  end

  def comment_params
    permitted_params = super
    permitted_params.merge(
      commentable_type: 'Report',
      commentable_id: params[:report_id]
    )
  end
end
