# frozen_string_literal: true

class RentsController < ApiController
  def create
    user = User.find(params[:user_id])
    @rent = user.rents.new(rent_params)
    authorize @rent

    return render json: { error: @rent.errors }, status: :bad_request unless @rent.save
    RentMailer.new_rent_notification(@rent).deliver_later
    render json: { message: 'Rent succesfully created!' }, status: :created
  end

  def index
    if params['book_id']
      rents = Book.find(params[:book_id]).rents
    elsif params['user_id']
      rents = User.find(params[:user_id]).rents
    end

    render_paginated policy_scope(rents)
  end

  private

  def rent_params
    params.require(:rent).permit(:loan, :restitution, :user_id, :book_id)
  end
end
