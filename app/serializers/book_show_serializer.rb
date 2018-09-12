# frozen_string_literal: true

class BookShowSerializer < BookSerializer
  attribute :image, key: :image_url

  has_many :rents, key: :actual_rent do
    object.rents.actual
  end
end
