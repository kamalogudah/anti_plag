Rails.application.routes.draw do
	resources :docs , only: [:index ,:new , :create , :destroy]
  get 'docs/index'
  get 'docs/new'
  get 'docs/create'
  get 'docs/destroy'
  get 'home/index'

  root 'docs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'application/hello'
end
