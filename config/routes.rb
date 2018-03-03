Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resource :session, only: [:create, :destroy], controller: "token/controllers/session"
      resources :movies, except: [:new, :edit], controller: "movie/controllers/movies"
    end
  end
end
