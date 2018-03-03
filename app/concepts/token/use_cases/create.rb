# frozen_string_literal: true

module Token
  module UseCases
    class Create < Base::UseCases::Create
      include Token::Dependencies[token_repository: "token_repository"]

      def call(params)
        token_repository.create(
          validate!(params),
        )
      end

      private

      def validator
        Forms::Create
      end
    end
  end
end
