# frozen_string_literal: true

BASE_URL = 'https://openlibrary.org/api/'

class OpenLibraryService
  include HTTParty

  def book_info(isbn)
    response = HTTParty.get(
      BASE_URL +
      "books?bibkeys=ISBN:#{isbn}&format=json&jscmd=data"
    )

    format_response(response.body, isbn)
  end

  def format_response(response, isbn)
    parsed_response = JSON.parse(response)
    book = parsed_response["ISBN:#{isbn}"]
    {
      'ISBN': book['identifiers']['isbn_10'][0],
      'Title': book['title'],
      'Subtitle': book['subtitle'],
      'Number of Pages': book['number_of_pages'],
      'Authors': book['authors'].map { |author| author['name'] }
    }
  end
end
