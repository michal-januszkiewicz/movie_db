# frozen_string_literal: true

module JwtToken
  class Service
    class << self
      def valid?(token)
        JWT.decode(token, ENVied.SECRET_KEY_BASE, true, algorithm: "HS512")
      rescue StandardError
        false
      end
    end
  end
end
