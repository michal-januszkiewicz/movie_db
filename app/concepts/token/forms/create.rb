# frozen_string_literal: true

module Token
  module Forms
    Create = Dry::Validation.Form do
      required(:value).filled(:str?)
      required(:user_id).filled(:str?)
    end
  end
end
