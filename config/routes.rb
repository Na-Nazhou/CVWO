Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get 'password_resets/new'
  get 'password_resets/edit'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  patch '/users/:user_id/tasks/:id/complete', to: 'tasks#complete', as: 'user_task_complete'
  patch '/users/:user_id/tasks/:id/uncomplete', to: 'tasks#uncomplete', as: 'user_task_uncomplete'
  resources :users do
    resources :tasks
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
