class UsersController < ApplicationController
  authorize_resource

  def index
    @users = User.all
  end

  def edit_role
    user = User.find(params[:id])
    user.role = params[:role]
    user.save
    head :no_content
  end
end
