# frozen_string_literal: true

module RatingUpdater
  class Service
    include MovieRating::Dependencies[rating_repository: "movie_rating_repository"]
    include Movie::Dependencies[movie_repository: "movie_repository"]

    # TODO: Add to a sidekiq job.
    def call(movie_id)
      ratings = rating_repository.all_for_movie(movie_id).pluck(:value)
      average = (ratings.sum.to_f / ratings.size).round
      movie_repository.update(movie_id, rating: average)
    end
  end
end
