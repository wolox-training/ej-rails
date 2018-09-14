# frozen_string_literal: true

class RentsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    rent = user.rents.new(rent_params)

    if rent.save
      render json: rent, status: :created, serializer: RentSerializer
    else
      render json: { error: rent.errors }, status: :bad_request
    end
  end

  def index
    if params['book_id']
      book_id = Book.find(params[:book_id])
      rents = Rent.where(book_id: book_id)
    elsif params['user_id']
      user_id = User.find(params[:user_id])
      rents = Rent.where(user_id: user_id)
    end

    render_paginated rents, each_serializer: RentSerializer
  end

  private

  def rent_params
    params.require(:rent).permit(:loan, :restitution, :user_id, :book_id)
  end
end
