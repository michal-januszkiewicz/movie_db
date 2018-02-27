# frozen_string_literal: true

module Token
  module UseCases
    class Update < Base::UseCases::Update
      include Token::Dependencies[token_repository: "token_repository"]

      def call(params)
        super
        token_value = find_active_token_value(params[:user_id])
        token_repository.update(token_value, revoked: params[:revoked])
      end

      private

      def validator
        Forms::Update
      end

      def find_active_token_value(user_id)
        @active_token ||= token_repository.one_active_by_user(user_id).value
      end
    end
  end
end
