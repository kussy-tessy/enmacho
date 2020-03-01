Rails.application.routes.draw do
  get 'kigurumi', to: 'kigurumi#index'
  get 'kigurumi/search', to: 'kigurumi#search'
  get 'kigurumi/new'
  post 'kigurumi/create'
  get 'kigurumi/:id', to: 'kigurumi#show'
  get 'kigurumi/:id/edit', to: 'kigurumi#edit'
  post 'kigurumi/:id', to: 'kigurumi#update'

  get 'person/auto_complete'
  get 'person/auto_complete_twitter'
  get 'person/kigurumis'
  get 'character/auto_complete'
  get 'work/auto_complete'
  get 'factory/bases'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
