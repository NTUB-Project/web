Rails.application.routes.draw do
  resources :gmaps
  resources :matters
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks"  }

  resources :products do
    resources :comments
  end

  resources :people_numbers
  resources :activity_kinds
  resources :regions
  resources :categories
  resources :comments

  get '/grounds/search/:id' => 'grounds#search'
  get '/foods/search' => 'foods#search'
  get '/rentcars/search' => 'rentcars#search'
  get '/equipments/search' => 'equipments#search'
  get '/costumes/search' => 'costumes#search'
  get '/custommade/search' => 'custommade#search'
  get '/searches/search' => 'searches#search'
  get '/searches' => 'searches#index'
  resources :equipments, :foods, :grounds, :rentcars, :costumes, :custommade do
    collection do
      get :search
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
      get :matter, path:'matter/:id'
      post :matter_send, path:'matter_send/:id'
      post :matter_form_send, path:'matter_form_send/:id'
    end
  end

  # put '/carts/:id', to: 'carts#update'



end
