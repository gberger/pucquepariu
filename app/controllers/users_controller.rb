class UsersController < ApplicationController
  authorize_resource

  def index
    @users = User.all
  end

  def toggle_admin
    user = User.find(params[:id])
    user.is_admin = !user.is_admin
    user.save
    redirect_to users_path
  end
end
