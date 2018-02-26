# frozen_string_literal: true

module Token
  module UseCases
    class Create
      include Token::Dependencies[token_repository: "token_repository"]

      def call(params)
        token_repository.create(params)
      end
    end
  end
end
