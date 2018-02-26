Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resource :session, only: [:create], controller: "token/controllers/session"
    end
  end
end
