# frozen_string_literal: true

module User
  class Container
    extend Dry::Container::Mixin

    register("user_repository") { Repository.new(ROM.env) }
  end
end
