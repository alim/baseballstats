Baseballstats::Application.routes.draw do
  resources :fantasy_points

  root :to => 'home#index'  
end
