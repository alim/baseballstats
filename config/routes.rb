Baseballstats::Application.routes.draw do
  resources :batting_statistics do
    collection { post :import }  
  end

  resources :fantasy_points

  root :to => 'home#index'  
end
