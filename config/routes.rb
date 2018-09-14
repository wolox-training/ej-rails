# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books, only: %i[index show] do
    resources :rents, only: %i[index]
  end

  resources :users, only: %i[index show] do
    resources :rents, only: %i[index create]
  end
end
