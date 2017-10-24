Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'groups#index'

  resources :topics do
    member do
      post 'upvote'
      post 'downvote'
    end
  end

  resources :groups do
    resources :posts
  end


end
