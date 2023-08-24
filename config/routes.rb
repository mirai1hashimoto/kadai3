Rails.application.routes.draw do
  devise_for :users
  get 'home/about' => "homes#about"
  resources :users
  resources :books #, only: [:new, :create, :index, :show, :edit, :destroy]
  root to: "homes#top"
end
