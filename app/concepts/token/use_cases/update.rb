# frozen_string_literal: true

module Token
  module UseCases
    class Update
      include Token::Dependencies[token_repository: "token_repository"]

      def call(user_id, params)
        token_value = find_active_token_value(user_id)
        token_repository.update(token_value, params)
      end

      private

      def find_active_token_value(user_id)
        @active_token ||= token_repository.one_active_by_user(user_id).value
      end
    end
  end
end
