require 'rails_helper'
require 'webmock/rspec'
require 'nokogiri'

describe CatShops::HappyCatsService do
  describe '#fetch_cats' do
    let(:api_url) { 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml' }
    let(:xml_response) do
      <<-XML
      <cats>
        <cat>
          <title>Whiskers</title>
          <location>New York</location>
          <cost>10.99</cost>
          <img>http://example.com/whiskers.jpg</img>
        </cat>
        <cat>
          <title>Fluffy</title>
          <location>San Francisco</location>
          <cost>5.49</cost>
          <img>http://example.com/fluffy.jpg</img>
        </cat>
      </cats>
      XML
    end

    before do
      stub_request(:get, api_url)
        .to_return(status: 200, body: xml_response, headers: { 'Content-Type' => 'application/xml' })

      allow(ENV).to receive(:fetch).with('HAPPY_CATS_API_URL').and_return(api_url)
    end

    it 'fetches cats from the API and processes the XML response' do
      service = CatShops::HappyCatsService.new
      cats = service.fetch_cats

      expect(cats).to eq([
        {
          'name' => 'Whiskers',
          'location' => 'New York',
          'price' => 10.99,
          'image' => 'http://example.com/whiskers.jpg'
        },
        {
          'name' => 'Fluffy',
          'location' => 'San Francisco',
          'price' => 5.49,
          'image' => 'http://example.com/fluffy.jpg'
        }
      ])
    end
  end
end