# frozen_string_literal: true

module SpecHelpers
  module JwtToken
    def generate_token(payload)
      payload["exp"] = 24.hours.from_now.to_i
      JWT.encode(payload, ENVied.SECRET_KEY_BASE, "HS512")
    end
  end
end
