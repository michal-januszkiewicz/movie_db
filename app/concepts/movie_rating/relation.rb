# frozen_string_literal: true

module MovieRating
  class Relation < ROM::Relation[:sql]
    schema(:movie_ratings, infer: true) do
      associations do
        belongs_to :user
        belongs_to :movie
      end
    end
  end
end
