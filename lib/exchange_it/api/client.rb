# frozen_string_literal: true

module ExchangeIt
  module Api
    class Client
      include ExchangeIt::Api::Rest

      attr_reader :token

      def initialize(token)
        @token = token
      end
    end
  end
end
