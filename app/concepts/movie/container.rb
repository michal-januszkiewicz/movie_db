# frozen_string_literal: true

module Movie
  class Container
    extend Dry::Container::Mixin

    register("movie_repository") { Repository.new(ROM.env) }

    namespace "use_cases" do
      register("index") { UseCases::Index.new }
    end

    namespace "forms" do
      register("index") { Forms::Index }
    end
  end
end
