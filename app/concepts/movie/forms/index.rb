# frozen_string_literal: true

module Movie
  module Forms
    Index = Dry::Validation.Form do
      optional(:search).filled(:str?)
      optional(:category_filter).value(included_in?: ENVied.MOVIE_CATEGORIES)
      optional(:rating_filter).filled { int? & gteq?(1) & lteq?(5) }
    end
  end
end
