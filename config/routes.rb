Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resource :session, only: [:create, :destroy], controller: "token/controllers/session"
      resources :movies, except: [:new, :edit], controller: "movie/controllers/movies"
      resources :movie_ratings, except: [:index, :show, :new, :edit],
        controller: "movie_rating/controllers/movie_ratings"
    end
  end
end
