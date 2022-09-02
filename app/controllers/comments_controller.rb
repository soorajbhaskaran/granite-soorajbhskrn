# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :load_task!

  def create
    comment = @task.comment.new(comment_params.mergea(user: current_user))
    comment.save!
    respond_with_json
  end

  def show
    authorize @task
    @comments = @task.comments.order("created_at DESC")
  end

  private

    def load_data!
      @task = Task.find_by!(id: comments_params[:task_id])
    end

    def comments_params
      params.require(:comment).permit(:task_id, :content)
    end
end
