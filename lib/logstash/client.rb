require_relative "client/version"
require_relative "client/connection"
require_relative "client/connection_decorator"
require_relative "client/table_request_template"
require_relative "client/response"
require_relative "client/request"

module Logstash
  module Client
    extend self

    def new url, &blk
      connection = Connection.new(url: url, &blk)
      @client = ConnectionDecorator.new(connection)
    end

    def current_connection
      @client
    end

  end
end
