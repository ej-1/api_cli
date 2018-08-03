require 'json'
require 'faraday'

class ApiClient

  # BASE_URL could be stored in a separate file and passed in to make the class even more agnostic.
  BASE_URI = 'https://driftrock-dev-test.herokuapp.com'.freeze

  def self.get(path) # BASE_URI
    # stringyfiy data here, but we don't really need that for this challenge.
    conn = Faraday.new(:url => BASE_URI)
    response = conn.get do |req|
      req.url path
      req.options.timeout = 5           # open/read timeout in seconds
      req.options.open_timeout = 2      # connection open timeout in seconds
    end
    self.handle_response(response)
  end

  private

  def self.handle_response(response)
    if response.status == 200
      [JSON.parse(response.body)]
    else
      [nil, JSON.parse(response)]
    end
  end
end
