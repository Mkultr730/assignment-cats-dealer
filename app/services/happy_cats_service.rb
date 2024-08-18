require 'nokogiri'

class HappyCatsService < CatShopService
  def fetch_prices
    response = RestClient.get(ENV['HAPPY_CATS_API_URL'])
    parsed_response = Nokogiri::XML(response.body)

    parsed_response.xpath('//cat').map do |cat_node|
      {
        'name' => cat_node.xpath('title').text,
        'location' => cat_node.xpath('location').text,
        'price' => cat_node.xpath('cost').text.to_f,
        'image' => cat_node.xpath('img').text
      }
    end
  end
end