Rails.application.routes.draw do
  get "/notes/export_every", to: "notes#export_every", as: "export_every_notes"

  resources :notes
  resources :books

  resources :notes do
    member do
      get 'export'
    end
  end

  # resources :notes do
  #   collection do
  #     get 'export_every'
  #   end
  # end


  resources :books do
    member do
      get 'export'
    end
  end


  devise_for :users

  get 'home/index'

  root to:"home#index"

  get '/notes/new/:book_id', to: 'notes#new'  #Rever

  get "/articles", to: "articles#index"

end

