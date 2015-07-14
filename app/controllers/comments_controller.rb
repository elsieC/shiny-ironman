class CommentsController < ApplicationController

  def new
    # This should be called when reply is clicked... ?
    @comment = Comment.new()
  end

  def create
    @comment = Comment.new()
    @comment.member_id = current_member.id

    # TODO is there a better way to do this post_id than a hidden_field (for replies)
    # See _comments.html.erb
    # binding.pry

    # If comment is a reply
    if params[:parent_id]
      @comment.parent_comment_id = params[:parent_id].to_i
      @comment.text = params[:text]
    else
      @comment.post_id = params[:post_id].to_i
      @comment.text = params[:comment][:text]
    end

    if @comment.save
      # TODO Fix this, it's broken and doesn't take params in this way.
      redirect_to post_path(@comment.get_post_id)
    else
      # TODO how to I print the error from here? Comment save fails when the
      # comment text is too dang short
      # find error here : @comment.errors
      render post_path(@comment.get_post_id)
      # render post_path(@comment.post_id)
    end
    # binding.pry
  end
end