# frozen_string_literal: true

module Base
  class ApiController < ActionController::API
    include Concerns::ExceptionsHandler
    include Concerns::Responder
    include User::Dependencies[user_repository: "user_repository"]
    include JwtToken::Dependencies[jwt_token: "jwt_token"]
    before_action :authenticate_request!

    private

    def current_user
      return unless decoded_token
      user_repository.one_by_email(decoded_token.first["email"])
    end

    def authenticate_request!
      raise Errors::Unauthenticated, "unauthenticated" unless decoded_token && token_active
    end

    def token_active
      @token_active = token_repo.one_active_by_value(http_token)
    end

    def decoded_token
      @decoded_token = jwt_token.valid?(http_token)
    end

    def http_token
      @http_token ||= request.headers.fetch("AUTHORIZATION", "").split.last
    end
  end
end
