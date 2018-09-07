# frozen_string_literal: true

class BookIndexSerializer < BookSerializer
  attributes :created_at, :updated_at
  attribute :image do
    {
      url: object.image
    }
  end

end
