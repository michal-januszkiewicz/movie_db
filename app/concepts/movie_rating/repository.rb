# frozen_string_literal: true

module MovieRating
  class Repository < ROM::Repository[:movie_ratings]
    commands :create, update: :by_pk, delete: :by_pk

    def all_for_movie(movie_id)
      movie_ratings
        .select(:id, :value)
        .where(movie_id: movie_id)
        .to_a
    end
  end
end
