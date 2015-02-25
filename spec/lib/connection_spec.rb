require "spec_helper"

describe Logstash::Client::Connection do

  before do
    @connection = described_class.new(url: "http://logcenter.server.io") do |logcenter|
      logcenter.login = "test"
      logcenter.password = "test_password"
      logcenter.result_size = 400
    end
    @client = @connection.client
  end

  specify { expect(@connection.class).to eql(Logstash::Client::Connection) }
  specify { expect(@connection.login).to eql("test") }
  specify { expect(@connection.password).to eql("test_password") }
  specify { expect(@client.http.class).to eql(Faraday::Connection) }
  specify { expect(@connection.send(:auths_present?)).to be_truthy }
end
