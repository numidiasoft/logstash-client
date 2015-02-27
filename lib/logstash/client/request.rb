module Logstash
  module Client
    class Request
      attr_reader :_method, :params

      def initialize(method: method, params: options)
        @_method = method
        @params = params
      end

      def next_page
        client = @_method.receiver  
        client.from  = client.from + client.result_size
        @_method.call(*params.values)
      end
    end
  end
end

