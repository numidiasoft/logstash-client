require "logstash/client/version"
require "logstash/client/connection"
require "logstash/client/connection_decorator"
require "logstash/client/table_request_template"

module Logstash
  module Client
    extend self

    def new url, &blk
      connection = Connection.new url, &blk
      @client = ConnectionDecorator.new(connection)
    end

  end
end
