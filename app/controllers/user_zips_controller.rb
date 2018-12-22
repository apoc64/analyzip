class UserZipsController < ApplicationController
  def create
    current_user.user_zips.create(uz_params)
    redirect_to user_path(current_user)
  end

  def update
    user_zip = current_user.user_zips.find(params[:id])
    user_zip.update(uz_params)
    redirect_to user_path(current_user)
  end

  def destroy
    user_zip = UserZip.find(params[:id])
    user_zip.destroy
    redirect_to user_path(current_user)
  end

  private

  def uz_params
    params.require(:user_zip).permit(:zip_id, :comment, :id)
  end
end
