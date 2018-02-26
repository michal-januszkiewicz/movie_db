# frozen_string_literal: true

module User
  Dependencies = Dry::AutoInject(User::Container)
end
