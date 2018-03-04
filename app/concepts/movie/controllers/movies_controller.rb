# frozen_string_literal: true

module Movie
  module Controllers
    class MoviesController < Base::ApiController
      include Movie::Dependencies[
        movies_index: "use_cases.index",
        create_movie: "use_cases.create",
        update_movie: "use_cases.update",
      ]
      skip_before_action :authenticate_request!, only: %i(index show)

      def index
        movies = movies_index.call(movie_filters)
        render_ok(movies)
      end

      def create
        movie = create_movie.call(movie_params)
        render_created(movie)
      end

      def update
        movie = update_movie.call(movie_params.merge(id: params[:id]))
        render_ok(movie)
      end

      private

      def movie_filters
        params.permit(:search, :category_filter, :rating_filter).to_h.symbolize_keys
      end

      def movie_params
        params
          .permit(:name, :description, categories: [])
          .to_h
          .symbolize_keys
          .merge(user_id: current_user[:id])
      end
    end
  end
end
