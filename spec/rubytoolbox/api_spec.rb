# frozen_string_literal: true

RSpec.describe Rubytoolbox::Api do
  let(:client) { described_class.new }

  it "has a version number" do
    expect(Rubytoolbox::Api::VERSION).not_to be nil
  end

  describe "initializer" do
    it "defaults endpoint_url to https://www.ruby-toolbox.com/api/" do
      expect(described_class.new.endpoint_url).to be == "https://www.ruby-toolbox.com/api/"
    end

    it "accepts a custom endpoint_url" do
      expect(described_class.new(url: "http://localhost:5000/api/").endpoint_url).to be == "http://localhost:5000/api/"
    end
  end

  describe "#compare" do
    it "returns an array of requested project results", :vcr do
      expect(client.compare("simplecov", "rspec")).to be_an(Array)
        .and have_attributes(count: 2)
    end

    it "raises a RequestError when requesting too many projects", :vcr do
      query = (1..1000).first(250)

      expect { client.compare(*query) }.to raise_error(
        described_class::RequestError, /Unexpected response status 400! Please request no more than/
      )
    end

    it "can handle errors without proper JSON response body" do
      stub_request(:get, File.join(client.endpoint_url, "projects", "compare", "boom"))
        .to_return status: 500, body: "foo bar baz"

      expect { client.compare "boom" }.to raise_error(
        described_class::RequestError, /Unexpected response status 500! foo bar baz/
      )
    end
  end
end
