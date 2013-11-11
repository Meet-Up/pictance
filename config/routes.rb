Pictance::Application.routes.draw do
	root to: 'static_pages#index'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :users
  resources :static_pages
end
