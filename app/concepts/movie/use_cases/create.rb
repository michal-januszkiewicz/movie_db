# frozen_string_literal: true

module Movie
  module UseCases
    class Create < Base::UseCases::Create
      include Movie::Dependencies[
        movie_repository: "movie_repository",
        create_form: "forms.create",
      ]

      def call(params)
        movie_repository.create(
          validate!(params),
        )
      end

      def validator
        create_form
      end
    end
  end
end
