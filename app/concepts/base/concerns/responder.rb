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

      def render_not_found(response = {})
        render status: :not_found, json: response
      end

      def render_forbidden(response = {})
        render status: :forbidden, json: response
      end
    end
  end
end
