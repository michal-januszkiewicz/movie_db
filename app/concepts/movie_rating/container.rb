# frozen_string_literal: true

module MovieRating
  class Container
    extend Dry::Container::Mixin

    register("movie_rating_repository") { Repository.new(ROM.env) }
  end
end
