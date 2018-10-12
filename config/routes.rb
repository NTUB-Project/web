Rails.application.routes.draw do
  resources :gmaps
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks"  }

  resources :products do
    resources :comments
  end

  resources :people_numbers
  resources :activity_kinds
  resources :regions
  resources :categories
  resources :comments

  post '/grounds/search' => 'grounds#search'
  post '/foods/search' => 'foods#search'
  post '/rentcars/search' => 'rentcars#search'
  post '/equipments/search' => 'equipments#search'
  post '/costumes/search' => 'costumes#search'
  post '/custommade/search' => 'custommade#search'
  post '/searches/search' => 'searches#search'
  post '/searches' => 'searches#index'
  resources :equipments, :foods, :grounds, :rentcars, :costumes, :custommade do
    collection do
      post :search
    end
  end
  resources :searches

  resources :home do
    get 'about', on: :collection
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

  resource :cart, only:[:show, :destroy] do

    collection do
      post :add, path:'add/:id'
      put :remove, path:'/:id'
      put :matter, path:'matter/:id'
      post :matter_send, path:'matter_send/:id'

    end
  end

  # put '/carts/:id', to: 'carts#update'



end
