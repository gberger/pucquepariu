class UsersController < ApplicationController
  authorize_resource

  def index
    @users = User.all
  end

  def edit_role
    user = User.find(params[:id])
    user.role = params[:role]
    if user.save
      head :ok
    else
      render json: user.errors.full_messages, status: :bad_request
    end
  end
end
