# frozen_string_literal: true

module Movie
  module UseCases
    class Index < Base::UseCases::Index
      include Movie::Dependencies[
        movie_repository: "movie_repository",
        index_form: "forms.index",
      ]

      def call(params)
        movie_repository.all(super)
      end

      def validator
        index_form
      end
    end
  end
end
