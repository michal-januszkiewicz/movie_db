# frozen_string_literal: true

module Base
  module Concerns
    module Responder
      extend ActiveSupport::Concern

      private

      def render_ok(response = {})
        render status: :ok, json: response
      end

      def render_created(response = {})
        render status: :created, json: response
      end
    end
  end
end
