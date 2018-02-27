# frozen_string_literal: true

module Errors
  class << self
    def error_constants
      %w(
        UnprocessableEntity
        Unauthenticated
        NotFound
        NotImplemented
      )
    end
  end
end

Errors.error_constants.each do |name|
  klass = Class.new(StandardError)
  Errors.const_set(name, klass)
end
