require 'rails_helper'
require 'webmock/rspec'
require 'rest-client'

describe CatShops::CatsUnlimitedService do
  describe '#fetch_cats' do
    let(:api_url) { 'http://example.com/api/cats' }
    let(:response_body) do
      [
        { 'name' => 'Whiskers', 'price' => 10.99, 'location' => 'Lviv',  'image' => 'https://img.net/images/img.jpg'},
        { 'name' => 'Fluffy', 'price' => 5.49, 'location' => 'Lviv',  'image' => 'https://img.net/images/img.jpg' }
      ]
    end

    before do
      stub_request(:get, api_url)
        .to_return(status: 200, body: response_body.to_json, headers: { 'Content-Type' => 'application/json' })

      allow(ENV).to receive(:fetch).with('CATS_UNLIMITED_API_URL').and_return(api_url)
    end

    it 'fetches cats from the API and processes the response' do
      service = CatShops::CatsUnlimitedService.new
      expect(service.fetch_cats).to eq(response_body)
    end
  end
end