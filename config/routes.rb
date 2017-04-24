Rails.application.routes.draw do
  resources :documents do
    get 'fill', on: :member
  end

  devise_for :users

  root 'dashboard#show'
end
