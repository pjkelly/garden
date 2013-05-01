Garden::Application.routes.draw do
  resources :seed_sources
  resources :categories do
    resources :sub_categories
  end

  resources :boxes do
    resources :squares
  end
  resources :squares do
    resources :plantings
  end
  resources :plantings, :only => [:index]
  resources :seeds

  devise_for :admins
  post '/admin/markdown_preview', :to => "application#markdown_preview"

  root :to => "home#index"
end
