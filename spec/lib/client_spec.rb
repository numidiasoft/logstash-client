require "spec_helper"

describe Logstash::Client do

  let(:client) do
    Logstash::Client.new("https://logcenter.numidiasoft.io") do |logcenter|
      logcenter.login = "me"
      logcenter.password = "me"
      logcenter.result_size = 2
      logcenter.prefix_path = "es"
    end
  end
 
  specify { expect(client.class).to be(Logstash::Client::ConnectionDecorator) }

  it "returns the requested items for the table" do
    table = "sleek_formatter-2015.02.24"
    date = "2015-02-24"
    ago = "24h"

    VCR.use_cassette("table") do
      response = client.table(table, date, ago)
      expect(response.body["hits"]["hits"].size).to be(2)
      expect(described_class.current_connection.class).to be(Logstash::Client::ConnectionDecorator)
    end
  end
end
