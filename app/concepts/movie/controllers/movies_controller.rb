# frozen_string_literal: true

module Movie
  module Controllers
    class MoviesController < Base::ApiController
      include Movie::Dependencies[
        movies_index: "use_cases.index",
      ]
      skip_before_action :authenticate_request!, only: %i(index show)

      def index
        movies = movies_index.call(movie_filters)
        render_ok(movies)
      end

      private

      def movie_filters
        params.permit(:search, :category_filter, :rating_filter).to_h.symbolize_keys
      end
    end
  end
end
