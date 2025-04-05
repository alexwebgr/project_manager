class CommentsController < ApplicationController
  def create
    @post = Project.find(params[:project_id])
    @comment = @post.comments.new(comment_params)

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: 'Failed to create comment.' }
      end
    end
  end

  def create_from_status_change
    @project = Project.find(params[:project_id])
    previous_status = @project.status

    if @project.update(status: params[:status])
      @project.comments.create(content: "Status changed from #{previous_status} to #{@project.status}")

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @project, notice: 'Status updated and comment created.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to @project, alert: 'Failed to update status.' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
