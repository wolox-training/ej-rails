# frozen_string_literal: true

class RentSerializer < ActiveModel::Serializer
  attributes :id, :loan, :restitution
  
  belongs_to :user
  belongs_to :book
end
