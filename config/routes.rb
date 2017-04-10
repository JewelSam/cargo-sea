Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      scope defaults: {format: :json} do
        resources :ships, only: [] do
          get :get_cargo, on: :member
        end

        resources :cargos, only: [] do
          get :get_ship, on: :member
        end
      end
    end
  end

end
