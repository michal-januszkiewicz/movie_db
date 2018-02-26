# frozen_string_literal: true

module Token
  module Controllers
    class SessionController < Base::ApiController
      include Token::Dependencies[create_token: "use_cases.create"]
      include JwtToken::Dependencies[jwt_token: "jwt_token"]
      skip_before_action :authenticate_request!

      def create
        validate_token!
        create_token.call(token_params)
        render_created(current_user)
      end

      private

      def validate_token!
        raise ::Errors::Unauthenticated, "unauthenticated" unless jwt_token.valid?(token_value)
        request.headers["AUTHORIZATION"] = token_value
      end

      def token_params
        {
          value: token_value,
          user_id: current_user.id,
        }
      end

      def token_value
        @token_value ||= params[:token]
      end
    end
  end
end
