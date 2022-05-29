# frozen_string_literal: true

module ExchangeIt
  module Api
    module Connection
      BASE_URL = 'https://api.lokalise.com/api2/'

      def connection(client)
        Faraday.new(options(client)) do |faraday|
          faraday.adapter Faraday.default_adapter
        end
      end

      private

      def options(client)
        {
          headers: {
            accept: 'application/json',
            user_agent: 'ruby-client',
            'X-Api-Token' => client.token
          },
          url: BASE_URL
        }
      end
    end
  end
end
