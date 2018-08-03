describe ClientRunner do

  before do
    TwitterApiClient.assign_token_preparer(OauthAccessTokenPreparer)
    @client_runner = ClientRunner
    @api_client = TwitterApiClient.new
  end

  context 'receives valid twitter username' do
    it 'prints something' do
      command_line_input = 'realdonaldtrump'
      expect { @client_runner.run_request(@api_client,
        'get', command_line_input, 5) }.to output.to_stdout
    end
  end

  context 'receives invalid twitter username' do
    it 'prints error message' do
      command_line_input = 'SOMEINVALIDUSERNAME'
      expect { @client_runner.run_request(@api_client,
        'get', command_line_input, 5) }.to output("ERROR: No tweets found for this user name!\n").
        to_stdout
    end
  end
end
