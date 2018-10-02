# frozen_string_literal: true

class BooksController < ApiController
  def index
    render_paginated Book, each_serializer: BookIndexSerializer
  end

  def show
    render json: Book.find(params[:id]), serializer: BookShowSerializer
  end

  def find_by_isbn
    book_service = open_library_service

    render json: book_service.book_info(params[:isbn])
  end

  def open_library_service
    @open_library_service ||= OpenLibraryService.new
  end
end
