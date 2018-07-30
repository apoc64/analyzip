class UserZipsController < ApplicationController
  def create
    current_user.user_zips.create(uz_params)
    redirect_to user_path(current_user)
  end

  def update
    current_user.user_zips.update(uz_params)
    redirect_to user_path(current_user)
  end

  def destroy
    # binding.pry
    user_zip = UserZip.find(params[:id])
    user_zip.destroy
    redirect_to user_path(current_user)
  end

  private

  def uz_params
    params.require(:user_zip).permit(:zip_id, :comment)
  end
end
