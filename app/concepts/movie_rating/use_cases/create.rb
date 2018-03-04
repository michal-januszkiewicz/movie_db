# frozen_string_literal: true

module MovieRating
  module UseCases
    class Create < Base::UseCases::Create
      include RatingUpdater::Dependencies[rating_updater: "rating_updater"]
      include MovieRating::Dependencies[
        movie_rating_repository: "movie_rating_repository",
        create_form: "forms.create",
      ]

      def call(params)
        created_rating = movie_rating_repository.create(
          validate!(params),
        )
        rating_updater.call(params[:movie_id])
        created_rating
      end

      private

      def validator
        create_form
      end
    end
  end
end
