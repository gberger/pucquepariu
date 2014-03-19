class UsersController < ApplicationController
  def index
    authorize! :read, User
    @users = User.all
  end

  def role
    authorize! :manage, User
    user = User.find(params[:id])
    user.role = params[:role]
    if user.save
      head :ok
    else
      render json: user.errors.full_messages, status: :bad_request
    end
  end
end
