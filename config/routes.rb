Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  resources :topics do
    member do
      post 'upvote'
      post 'downvote'
    end
  end

  resources :groups do
    member do
      post :join
      post :quit
    end
    resources :posts
  end

  namespace :account do
    resources :groups
    resources :posts
  end

  resources :jobs do
    resources :resumes
  end

  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
  end

end
