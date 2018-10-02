# frozen_string_literal: true

class UsersController < ApiController
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: { error: user.errors }, status: :bad_request
    end
  end

  def index
    render_paginated User
  end

  def show
    render json: User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :nickname, :image)
  end
end
