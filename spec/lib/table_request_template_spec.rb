require "spec_helper"
require "json"

describe Logstash::Client::TableRequestTemplate do
  let(:date) { "2015-02-25" }
  let(:ago) { "24h" }

  it "generates json request to load a table by date range" do
    request = JSON.parse(described_class.content(date: date, ago: ago))
    timestamp = request["query"]["filtered"]["filter"]["bool"]["must"].first["range"]["@timestamp"]
    expect(timestamp["gt"]).to eql("#{date}||-#{ago}")
    expect(timestamp["lte"]).to eql(date)
  end

  it "sets the right response size" do
    request = JSON.parse(described_class.content(size: 2, date: date, ago: ago))
    expect(request["size"]).to eql(2)
  end
end
