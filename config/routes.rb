Rails.application.routes.draw do
  # Makers
  get 'makers/index'
  get 'makers/show'

  # Bodies
  get 'bodies/index'
  get 'bodies/show'

  # Lenses
  match 'lenses/index', to: 'lens_models#index', via: 'get'
  match 'lenses/show', to: 'lens_models#show', via: 'get'

  # Pictures
  get 'pictures/index'
  get 'pictures/new'
  get 'pictures/show'
  get 'pictures/init'
  post 'pictures/create'
end
