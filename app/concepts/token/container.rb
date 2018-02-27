# frozen_string_literal: true

module Token
  class Container
    extend Dry::Container::Mixin

    namespace "use_cases" do
      register("create") { UseCases::Create.new }
      register("update") { UseCases::Update.new }
    end

    register("token_repository") { Repository.new(ROM.env) }
  end
end
