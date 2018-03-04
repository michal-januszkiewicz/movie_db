# frozen_string_literal: true

module MovieRating
  module Controllers
    class MovieRatingsController < Base::ApiController
      include MovieRating::Dependencies[
        create_movie_rating: "use_cases.create",
      ]

      def create
        movie_rating = create_movie_rating.call(movie_rating_params)
        render_created(movie_rating)
      end

      private

      def movie_rating_params
        params
          .permit(:movie_id, :value)
          .to_h
          .symbolize_keys
          .merge(user_id: current_user[:id])
      end
    end
  end
end
