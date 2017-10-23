Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'topics#index'

  resources :topics do
    member do
      post 'upvote'
      post 'downvote'
    end
  end
end
