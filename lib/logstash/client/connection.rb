require "faraday"

module Logstash
  module Client
    class Connection
      attr_accessor :login, :password, :result_size, :logger, :prefix_path, :http

      def initialize(url: url, &blk)
        @url = url
        blk.call(self) if block_given?
      end

      def client
        @http ||= ::Faraday.new(:url => @url) do |faraday|
          faraday.request  :url_encoded             # form-encode POST params
          faraday.response logger if logger == true
          faraday.adapter  ::Faraday.default_adapter  # make requests with Net::HTTP
          faraday.basic_auth(login, password) if  auths_present?
        end
        self
      end

      private
      def auths_present?
        !(password && login).nil?
      end
      
      def logger
        @logger || :logger
      end

    end
  end
end
