Rails.application.routes.draw do
  resources :products
  resources :people_numbers
  resources :activity_kinds
  resources :regions
  resources :categories

  devise_for :users

  resources :equipments, :foods, :grounds, :rentcars, :costumes, :photography, :custommade do
    collection do
      post :search
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

  if Rails.env.development?
     mount LetterOpenerWeb::Engine, at: "/letter_opener"
   end

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add, path:'add/:id'
    end
  end

  mount Commontator::Engine => '/commontator'

end
