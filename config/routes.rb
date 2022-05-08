Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :osusowake do
    get '/',         to: 'home#index'
    get 'index',     to: 'home#index'
  end
end
