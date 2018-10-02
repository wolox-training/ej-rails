# frozen_string_literal: true

ActiveAdmin.register Rent do
  permit_params :loan, :restitution, :book_id, :user_id
end
