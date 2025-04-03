Rails.application.routes.draw do
  get 'categories/new'
  devise_for :users
  get 'items/index'
root to: "items#index"

resources :items do
  resources :orders, only: [:index, :create]
end

end
