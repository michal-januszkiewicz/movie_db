# frozen_string_literal: true

module Token
  class Repository < ROM::Repository[:tokens]
    commands :create, :update
  end
end
