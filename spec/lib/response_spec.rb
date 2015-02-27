require 'spec_helper'

describe Logstash::Client::Response do

  let(:client) do
    Logstash::Client.new("https://logcenter.numidiasoft.io") do |logcenter|
      logcenter.login = "me"
      logcenter.password = "me"
      logcenter.result_size = 2
      logcenter.prefix_path = "es"
    end
  end

  let(:options) do
    options = {
      index: "sleek_formatter-2015.02.24",
      date: "2015-02-24",
      ago: "24h"
    }
  end

  let(:request) do
    Logstash::Client::Request.new(method: client.method(:index), params: options)
  end

  let(:response) do
    Logstash::Client::Response.new(request: request, payload: {})
  end

  it "delegates next_page call to request" do
    VCR.use_cassette("next_page") do
     expect(response.request).to receive(:next_page)
     response.next_page
    end
  end

  it "returns body" do
    expect(response.body).to eq({})
  end

end
