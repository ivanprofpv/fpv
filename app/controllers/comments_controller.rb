class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy edit]
  before_action :find_drone, only: %i[create show update destroy edit]
  before_action :set_comment, only: %i[ show edit update destroy ]

  def index
  end

  def new
    @comment = Comment.new
  end

  def show
    @comments = Comment.all
  end

  def create
    @comment = @drone.comments.new(comment_params.merge(user_id: current_user.id))

    if @comment.save
      flash[:good] = "Comment created successfully."
      redirect_to @drone
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update

  end

  def destroy

  end

  def edit

  end

  private

  def comment_params
    params.require(:comment).permit(:body, :drone_id)
  end

  def find_drone
    @drone = Drone.find(params[:drone_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

end
