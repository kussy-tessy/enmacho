Rails.application.routes.draw do
  root :to => 'static#index'

  get 'random/edit' => 'random#edit', as: :random_edit
  get 'random/show' => 'random#show', as: :random_show

  resources :kigurumis do
    collection do
      get 'search'
    end
  end

  resources :people do
    collection do
      get 'kigurumis'
      get 'auto_complete'
      get 'auto_complete_twitter'
    end
  end

  resources :works, only: [:update]
  resources :characters, only: [:update]

  get 'characters/auto_complete', as: :auto_complete_characters
  get 'works/auto_complete', as: :auto_complete_works
  get 'factories/bases', as: :bases_factories_path
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
