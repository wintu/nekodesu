Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    get  '/'                                       => 'user#index'
  end

  get  '*path'                                     => 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
