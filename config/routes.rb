Rails.application.routes.draw do

  root to: 'dashboard#show'

  resource :slack_authentication, only: [:show] do
    collection do
      get 'callback'
    end
  end

  namespace :api do
    scope module: :v1 do
      resource :bantaclause, only: [:create]
    end
  end

end
