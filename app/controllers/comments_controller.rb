class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[ create update destroy edit ]
  before_action :find_drone, only: %i[ create update ]
  before_action :find_comment, only: %i[ update edit destroy upvote ]

  def index
  end

  def upvote
    if current_user.voted_up_on? @comment
      @comment.unvote_by current_user
    else
      @comment.upvote_by current_user
    end
    render 'vote.js.erb'
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @drone.comments.new(comment_params.merge(user_id: current_user.id))

    @comment.save
  end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  def edit
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_drone
    @drone = Drone.find(params[:drone_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

end
