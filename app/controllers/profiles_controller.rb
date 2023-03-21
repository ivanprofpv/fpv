class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: %i[show edit update]
  before_action :set_profile, only: %i[show edit update]
  before_action :set_other_profile, only: %i[show_other_profile]

  def show_other_profile
    render :other_profile
  end

  def show; end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_other_profile
    @profile = Profile.find(params[:id])
  end

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:name, :about, :city, :avatar)
  end
end
