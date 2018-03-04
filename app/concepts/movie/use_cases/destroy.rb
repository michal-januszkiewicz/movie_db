# frozen_string_literal: true

module Movie
  module UseCases
    class Destroy < Base::UseCases::Destroy
      include Movie::Dependencies[
        movie_repository: "movie_repository",
        destroy_form: "forms.destroy",
      ]

      def call(params)
        # TODO: Extract authorization.
        movie = fetch_movie(params[:id])
        raise Errors::Unauthorized unless movie[:user_id] == params[:user_id]
        validate!(params.except(:user_id))
        movie_repository.delete(params[:id])
      end

      private

      def fetch_movie(id)
        movie = movie_repository.one_by_id(id)
        raise Errors::NotFound unless movie
        movie
      end

      def validator
        destroy_form
      end
    end
  end
end
