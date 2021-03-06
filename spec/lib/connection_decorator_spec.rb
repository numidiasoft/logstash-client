require "spec_helper"

describe Logstash::Client::ConnectionDecorator do

  before do
    connection = Logstash::Client::Connection.new(url: "https://logcenter.numidiasoft.io") do |logcenter|
      logcenter.login = "me"
      logcenter.password = "me"
      logcenter.result_size = 2
      logcenter.from = 3
      logcenter.prefix_path = "es"
    end
    @decorated_connection = Logstash::Client::ConnectionDecorator.new(connection)
  end

  it "returns the nodes" do
    VCR.use_cassette("nodes") do
      response  = @decorated_connection.get('/_nodes')
      expect(response.class).to be(Hash)
      expect(response['cluster_name']).to eql("logcenter")
    end
  end

  it "returns data for a an index" do
    VCR.use_cassette("index") do
      index = "sleek_formatter-2015.02.24"
      date = "2015-02-24"
      ago = "24h"
      response = @decorated_connection.index(index, date, ago)
      expect(response.class).to be(Logstash::Client::Response)
      expect(response.body["hits"]["hits"].size).to be(2)
    end
  end

end
