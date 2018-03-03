# frozen_string_literal: true

module Movie
  Dependencies = Dry::AutoInject(Movie::Container)
end
