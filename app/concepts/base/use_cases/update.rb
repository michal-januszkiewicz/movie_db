# frozen_string_literal: true

module Base
  module UseCases
    class Update
      private

      def validate!(input)
        form = validator.call(input)
        raise Errors::UnprocessableEntity, form.messages if form.failure?
        form.output
      end

      def validator
        raise Errors::NotImplemented, "#{self} does not implement ::validator"
      end
    end
  end
end
