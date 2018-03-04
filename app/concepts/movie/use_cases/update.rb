# frozen_string_literal: true

module Movie
  module UseCases
    class Update < Base::UseCases::Update
      include Movie::Dependencies[
        movie_repository: "movie_repository",
        update_form: "forms.update",
      ]

      def call(params)
        # TODO: Extract authorization.
        movie = fetch_movie(params[:id])
        raise Errors::Unauthorized unless movie[:user_id] == params[:user_id]
        movie_repository.update(
          *update_params(params),
        )
      end

      private

      def fetch_movie(id)
        movie = movie_repository.one_by_id(id)
        raise Errors::NotFound unless movie
        movie
      end

      def update_params(params)
        [
          params[:id],
          validate!(params).except(:id, :user_id),
        ]
      end

      def validator
        update_form
      end
    end
  end
end
