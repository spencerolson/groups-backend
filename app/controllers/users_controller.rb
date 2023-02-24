class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def create
    user = User.find_or_initialize_by(username: user_params[:username])
    user.status = "available"
    ActionCable.server.broadcast('user_channel', user) if user.save
    render json: user
  end

  def logout
    user = User.find(params[:user_id])
    ActionCable.server.broadcast('user_channel', user) if user.update(status: "offline")
    head :ok
  end

  def add_message
    user = User.find(params[:user_id])
    message = params[:message]
    created_message = user.messages.create(content: message)
    ActionCable.server.broadcast('message_channel', created_message) if user.save
    head :ok
  end

  def user_params
    params.require(:user).permit(:username, :status)
  end
end
