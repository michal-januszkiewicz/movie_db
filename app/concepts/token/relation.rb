# frozen_string_literal: true

module Token
  class Relation < ROM::Relation[:sql]
    schema(:tokens, infer: true) do
      associations do
        belongs_to :user
      end
    end
  end
end
