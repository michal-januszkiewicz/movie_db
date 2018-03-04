# frozen_string_literal: true

module Movie
  module Forms
    Update = Dry::Validation.Form do
      required(:id).filled(:int?)
      optional(:name).filled(:str?)
      optional(:description).maybe(:str?)
      optional(:categories).each(included_in?: ENVied.MOVIE_CATEGORIES)
    end
  end
end
