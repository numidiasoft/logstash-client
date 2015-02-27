require 'forwardable'

module Logstash
  module Client
    class Response
      extend Forwardable
      def_delegators :@request, :next_page

      attr_reader :body, :request

      def initialize request: request, payload: payload
        @body = payload  
        @request = request
      end
    end
  end
end
