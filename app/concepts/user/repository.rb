# frozen_string_literal: true

module User
  class Repository < ROM::Repository[:users]
    commands :create, update: :by_pk, delete: :by_pk

    def one_by_email(email)
      users
        .where(email: email)
        .one
    end
  end
end
