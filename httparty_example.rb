require 'httparty'
require 'json'

response = HTTParty.get('http://bbc.co.uk/news')

# puts JSON.parse(response)

p response.message