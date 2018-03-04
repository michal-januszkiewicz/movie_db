# frozen_string_literal: true

module MovieRating
  class Container
    extend Dry::Container::Mixin

    namespace "use_cases" do
      register("create") { UseCases::Create.new }
    end

    namespace "forms" do
      register("create") { Forms::Create }
    end

    register("movie_rating_repository") { Repository.new(ROM.env) }
  end
end
