# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  resources :members, only: %i[new show create] do
    member do
      get :search
    end
  end

  get '/:id' => 'shortener/shortened_urls#show', as: :short

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
