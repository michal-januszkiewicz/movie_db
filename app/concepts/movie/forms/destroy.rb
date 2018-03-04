# frozen_string_literal: true

module Movie
  module Forms
    Destroy = Dry::Validation.Form do
      required(:id).filled(:int?)
    end
  end
end
