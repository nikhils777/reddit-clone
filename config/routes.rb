RedditClone::Application.routes.draw do
  get "posts/index"
  devise_for :users
  resources :users, only: [:update, :show, :index]
  resources :posts, only: [:index]
  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts' do
      resources :comments
      get '/up-vote' => 'votes#up_vote', as: :up_vote
      get '/down-vote' => 'votes#down_vote', as: :down_vote
      resources :favorites, only: [:create, :destroy]
    end
  end
  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
