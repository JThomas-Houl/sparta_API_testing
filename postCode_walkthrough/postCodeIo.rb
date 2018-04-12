require 'httparty'
require 'json'

class PostCodesio 
  include HTTParty
  
  attr_accessor :single_single_postcode_results
  
  base_uri 'https://api.postcodes.io/'


  def single_postcode_search(postcode)
    @single_postcode_results = self.class.get("/postcodes/#{postcode}")

    puts JSON.parse(@single_postcode_results.body)
  end 

  def muiltiple_postcodes_search(postcode_array)
    @muiltiple_postcodes_results = self.class.post("/postcodes/", :body => {'postcodes': postcode_array})
    puts JSON.parse(@muiltiple_postcodes_results.body)
  end

end

single = PostCodesio.new
# single.single_postcode_search('b601ja')
single.muiltiple_postcodes_search(['b601ja', 'sw155du'])


