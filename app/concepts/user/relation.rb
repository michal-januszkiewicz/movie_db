# frozen_string_literal: true

module User
  class Relation < ROM::Relation[:sql]
    schema(:users, infer: true) do
      associations do
        has_many :tokens
      end
    end
  end
end
