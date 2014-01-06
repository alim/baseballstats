Baseballstats::Application.routes.draw do

  # Search Routes
  get "search/index"
  post "search/improved"
  post "search/slugging"
  post "search/fantasy_improved"
  post "search/triple_crown"
  
  resources :players do
    collection { post :import }
  end

  resources :batting_statistics do
    collection { post :import }  
  end

  resources :fantasy_points

  root :to => 'home#index'  
end
