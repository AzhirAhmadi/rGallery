Rails.application.routes.draw do


  get "home" => "images#home", :as => "home"




  resources :images, :categories
  root "images#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
