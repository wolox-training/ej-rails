# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    render_paginated Book, each_serializer: BookIndexSerializer
  end

  def show
    render json: Book.find(params[:id]), serializer: BookShowSerializer
  end
end
