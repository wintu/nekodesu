Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    scope :user do
      post '/login'                                => 'user#login'
      post '/create'                               => 'user#create'
      get  '/current_login_user'                   => 'user#current_login_user'
      get  '/logout'                               => 'user#logout'
    end

    scope :file do
      post '/upload'                               => 'file#upload'
      scope ':id' do
        get  '/details'                            => 'file#details'
        get  '/data'                               => 'file#data'
        get  '/download'                           => 'file#download'
      end
    end

    scope :search do
      get '/title'                                         => 'search#title'
      get '/category'                                      => 'search#category'
      get '/tag'                                           => 'search#tag'
   end
  end
  get  '*path'                                     => 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
