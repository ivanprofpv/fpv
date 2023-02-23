class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy edit]
  before_action :find_drone, only: %i[create edit update destroy ]
  before_action :find_comment, only: %i[ update edit destroy ]

  def index
  end

  def new
    @comment = Comment.new
  end

  def show
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
    if @comment.update(comment_params)
      flash[:good] = "Comment updated successfully."
      redirect_to drone_path(@drone)
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    flash[:good] = "Comment deleted successfully."
    redirect_to drone_path(@drone)
  end

  def edit
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :drone_id, :user_id)
  end

  def find_drone
    @drone = Drone.find(params[:drone_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

end
