# frozen_string_literal: true

module RatingUpdater
  class Container
    extend Dry::Container::Mixin

    register("rating_updater") { RatingUpdater::Service }
  end
end
