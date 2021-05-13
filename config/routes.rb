# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :notes do
      collection do
        delete :destroy_collection
        patch :update_collection
        post :create_collection
        get 'notes(/:hash)', to: 'notes#by_queue_hash'
      end
    end
  end
end
