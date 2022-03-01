Rails.application.routes.draw do
  get 'event_users/user:references'
  get 'event_users/event:references'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :groups do
    resources :events, only: %i[index show new create]
    resources :usergroups, only: %i[index new create destroy] do
      member do
        put :accept
      end
    end
    resources :event_users, only: %i[index create]
  end
end
