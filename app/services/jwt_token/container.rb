# frozen_string_literal: true

module JwtToken
  class Container
    extend Dry::Container::Mixin

    register("jwt_token") { JwtToken::Service }
  end
end
