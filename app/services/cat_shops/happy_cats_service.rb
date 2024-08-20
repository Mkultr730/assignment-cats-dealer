require 'nokogiri'

class CatShops::HappyCatsService < CatShopService
  def fetch_cats
    response = RestClient.get(ENV['HAPPY_CATS_API_URL'])
    xml_doc = Nokogiri::XML(response.body)
    cats = xml_doc.xpath('//cat').map do |cat_node|
      {
        'name' => cat_node.xpath('title').text,
        'location' => cat_node.xpath('location').text,
        'price' => cat_node.xpath('cost').text.to_f,
        'image' => cat_node.xpath('img').text
      }
    end
  end
end