Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users
  get 'home/about' => "homes#about"
  resources :users
  resources :books do
    resource :favorites, only: [:destroy, :create]
    resources :book_comments, only: [:create, :destroy]
  end
  #resources :books, only: [:new, :create, :index, :show, :destroy, :edit]
  root to: "homes#top"
end
