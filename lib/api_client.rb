require 'json'
require 'open-uri'
require 'faraday'

class ApiClient

  BASE_URI = 'https://driftrock-dev-test.herokuapp.com'.freeze

  def self.get(path) # BASE_URI
    # stringyfiy data here
      conn = Faraday.new(:url => BASE_URI)
      response = conn.get path
      data = JSON.parse(response.body)
  end

=begin
  def get(twitter_user_name, count)
    handle_timeouts do
      response = access_token.request(:get, url(twitter_user_name, count))
      handle_response(response)
    end
  end
=end
  private

  def self.handle_response(response)
    if response.code == '200'
      if response.empty?
        'ERROR: No tweets found for this user name!'
      else
        response
      end
    else
      JSON.parse(response.body)
    end
  end

  def self.handle_timeouts_old
    begin
      yield
    rescue Net::OpenTimeout, Net::ReadTimeout
      { error: { message: 'Timeout error' } }
    end
  end

  def self.handle_timeouts
    perform_external_call
  rescue Timeout::Error => e
    @error = e
    render :action => "error" # ??????? { error: { message: 'Timeout error' } }
  end

  def self.send_request(api_client, request_type, payload, count)
    begin
      api_client.send(request_type, payload, count)
    rescue
      # Retry request 1 time if request fails.
      1.times { sleep 1, api_client.send(request_type, payload, count) }
    end
  end
end
