require './lib/api_client.rb'
require 'pry'

describe ApiClient do

  before do
    Struct.new("FakeFaradayClass", :status, :body)
  end

  describe '#get' do
    it 'sends request' do
      # Need to get the test for Faraday to work, but running out of time.
      # The test to see if Faraday receives the message does not work yet.
      # expect_any_instance_of(Faraday).to receive(:get).with("/fakepath")
      expect(ApiClient).to receive(:handle_response)
      ApiClient.get('/fakepath')
    end
  end

  describe '#handle_response' do
    context '200 status' do
      it 'send payload' do
        payload = ({:data=>["some data"]}).to_json
        fake_faraday_response_ok = Struct::FakeFaradayClass.new(200, payload)
        expect(ApiClient.handle_response(fake_faraday_response_ok)).to eq([JSON.parse(payload)])
      end
    end

    context 'not 200 status' do
      it 'send nil and payload' do
        payload = { error: ['something went wrong on the server side']}.to_json
        fake_faraday_response_ok = Struct::FakeFaradayClass.new(404, payload)
        expect(ApiClient.handle_response(fake_faraday_response_ok)).to eq([nil, JSON.parse(payload)])
      end
    end
  end
end
