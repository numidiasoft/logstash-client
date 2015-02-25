require_relative "client/version"
require_relative "client/connection"
require_relative "client/connection_decorator"
require_relative "client/table_request_template"

module Logstash
  module Client
    extend self

    def new url, &blk
      connection = Connection.new url, &blk
      @client = ConnectionDecorator.new(connection)
    end

  end
end
