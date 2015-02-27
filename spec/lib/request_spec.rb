require "spec_helper"

describe Logstash::Client::Request do

  before :all do
    @client = Logstash::Client.new("https://logcenter.numidiasoft.io") do |logcenter|
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
    Logstash::Client::Request.new(method: @client.method(:index), params: options)
  end

  it "returns a populated request" do
    expect(request._method.class).to be(Method)
    expect(request.params) == (options)
  end

  it "returns the page 0 of results" do
    VCR.use_cassette("next_page") do
     @client.index(options[:index], options[:date], options[:ago])
     expect(@client.from).to eql(0)
    end
  end

  it "returns the page 2 of results" do
    VCR.use_cassette("next_page") do
     response = request.next_page   
     expect(response.class).to be(Logstash::Client::Response)
     expect(@client.from).to eql(2)
    end
  end

  it "returns the page 3 of results" do
    VCR.use_cassette("next_page") do
     response = request.next_page   
     expect(response.class).to be(Logstash::Client::Response)
     expect(@client.from).to eql(4)
    end
  end
end

