# frozen_string_literal: true

module Token
  module Forms
    Update = Dry::Validation.Form do
      required(:user_id).filled(:str?)
      required(:revoked).filled(:bool?)
    end
  end
end
