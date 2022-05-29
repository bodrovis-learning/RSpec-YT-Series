# frozen_string_literal: true

module ExchangeIt
  module Api
    module Rest
      include ExchangeIt::Api::Request

      def project(project_id)
        get "projects/#{project_id}", self
      end

      def projects(params = {})
        get 'projects', self, params
      end

      def create_project(params)
        post 'projects', self, params
      end
    end
  end
end
