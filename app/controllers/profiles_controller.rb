class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[show edit update]
  before_action :set_profile, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    authorize @profile
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :about, :city)
  end
end
