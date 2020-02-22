Rails.application.routes.draw do
  get 'kigurumi/new'
  get 'kigurumi/create'
  get 'kigurumi/edit'
  get 'kigurumi/update'

  get 'person/auto_complete'
  get 'person/auto_complete_twitter'

  get 'character/auto_complete'
  get 'work/auto_complete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
