# frozen_string_literal: true

class BookSuggestionsController < ApplicationController
  def create
    @book_suggestion = BookSuggestion.new(book_suggestion_params)

    return render json: @book_suggestion, status: :created if @book_suggestion.save
    render json: { error: @book_suggestion.errors }, status: :bad_request
  end

  private

  def book_suggestion_params
    params.require(:book_suggestion).permit(:year, :editorial, :title, :link, :user_id,
                                            :price, :author, :publisher)
  end
end
