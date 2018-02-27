# frozen_string_literal: true

module Token
  class Repository < ROM::Repository[:tokens]
    commands :create, update: :by_pk

    def active
      tokens
        .where(revoked: false)
    end

    def one_active_by_value(token_value)
      active
        .where(value: token_value)
        .one
    end

    def one_active_by_user(user_id)
      active
        .where(user_id: user_id)
        .one
    end
  end
end
