Rails.application.routes.draw do
  # Makers
  resources :makers, only: %w(index show)

  # Bodies
  resources :bodies, only: %w(index show)

  # Lenses
  match 'lenses/index', to: 'lens_models#index', via: 'get'
  match 'lenses/show', to: 'lens_models#show', via: 'get'

  # Pictures
  resources :pictures, only: %w(index new show init create)
  post 'pictures/init'
end
