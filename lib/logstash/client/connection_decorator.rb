require "json"
require "delegate"

module Logstash
  module Client
    class ConnectionDecorator < ::SimpleDelegator

      def get path
        response = client.http.get(build_path(path))
        return response.body if response.status != 200
        JSON.parse(response.body)
      end

      def post url, params
        response = client.http.post(build_path(url), params)
        return response.body if response.status != 200
        JSON.parse(response.body)
      end

      def table(table, date, ago)
        url = '/'.concat(table).concat('/_search')
        table_request_template =  TableRequestTemplate.content(size: client.result_size, from: from,  date: date, ago: ago)
        request ||= Request.new(method: self.method(:table), params: { table: table, date: date, ago: ago })
        payload = self.post(url, table_request_template)
        response = Response.new(request: request , payload: payload)
      end

      def build_path path
        if client.prefix_path
          prefix_path + path
        else
          path
        end
      end
    end
  end
end
