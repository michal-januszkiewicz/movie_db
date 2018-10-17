# frozen_string_literal: true

module Token
  module Controllers
    class SessionController < Base::ApiController
      include Token::Dependencies[
        create_token: "use_cases.create",
        update_token: "use_cases.update",
      ]
      skip_before_action :authenticate_request!, only: :create

      def create
        validate_token!
        create_token.call(value: token_value, user_id: current_user.id)
        render_created(current_user)
      end

      def destroy
        updated_token = update_token.call(user_id: current_user.id, revoked: true)
        render_ok(updated_token)
      end

      private

      def validate_token!
        raise ::Errors::Unauthenticated, "unauthenticated" unless jwt_token.valid?(token_value)
        request.headers["AUTHORIZATION"] = token_value
      end

      def token_value
        @token_value ||= params[:token]
      end
    end
  end
end
