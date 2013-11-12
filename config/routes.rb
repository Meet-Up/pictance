Pictance::Application.routes.draw do
	root to: 'static_pages#index'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :users do
    collection do
      get 'ranking'
      get 'loading'
      get 'fetch_photo'
    end
  end
  resources :static_pages
end
