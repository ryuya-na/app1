Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'hello#index'

  get 'diaries/condition' => 'diaries#condition_index'
  
  resources :diaries
 
  
end
