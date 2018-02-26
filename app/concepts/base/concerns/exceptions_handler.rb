# frozen_string_literal: true

module Base
  module Concerns
    module ExceptionsHandler
      extend ActiveSupport::Concern

      included do
        rescue_from ROM::TupleCountMismatchError, with: :not_found
        rescue_from Errors::NotFound, with: :not_found
        rescue_from Errors::UnprocessableEntity, with: :unprocessable_entity
        rescue_from Errors::Unauthenticated, with: :unauthenticated
      end

      private

      def unprocessable_entity(exception)
        render status: :unprocessable_entity, json: { errors: exception.message }
      end

      def not_found(exception)
        render status: :not_found, json: { errors: exception.message }
      end

      def unauthenticated(exception)
        render status: :unauthorized, json: { errors: exception.message }
      end
    end
  end
end
