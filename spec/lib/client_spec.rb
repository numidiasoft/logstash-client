require "spec_helper"

describe Logstash::Client do

  let(:client) do
    Logstash::Client.new(url: "https://logcenter.numidiasoft.io") do |logcenter|
      logcenter.login = "me"
      logcenter.password = "me"
      logcenter.result_size = 1
      logcenter.prefix_path = "es"
    end
  end
 
  specify { expect(client.class).to be(Logstash::Client::ConnectionDecorator) }
end
