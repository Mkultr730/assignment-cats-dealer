Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cats do
    collection do
      get 'best_deal'
    end
  end
end
