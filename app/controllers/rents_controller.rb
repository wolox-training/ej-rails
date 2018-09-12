# frozen_string_literal: true

class RentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    rent = book.rents.new(rent_params)

    if rent.save
      render json: rent, status: :created, serializer: RentSerializer
    else
      render json: {error: rent.errors}, status: :bad_request
    end
  end

  def index
    book_id = Book.find(params[:book_id])
    render_paginated Rent.where(book_id: book_id), each_serializer: RentSerializer
  end

  private

  def rent_params
    params.require(:rent).permit(:loan, :restitution, :user_id)
  end
end
