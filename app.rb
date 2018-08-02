require './lib/api_client.rb'
require './helpers/iterator_helper'


class DriftRockCli
  extend IteratorHelper

  def self.execute(args)
    case args[0]
    when 'most_sold'
      response      = ApiClient.get('/purchases')
      puts highest_count(response['data'], 'item')
    when 'total_spend' # ruby app.rb total_spend schimmel_quincy@ernser.io 
      user_email = args[1]
      # add a catch here. if emails is empty
      response_users      = ApiClient.get('/users')
      response_purchases  = ApiClient.get('/purchases')
      user = select_hashes(response_users['data'], 'email', user_email)
      if user.empty?
        # should the output maybe be JSON?
        puts 'No user found with that email'
      else
        purchases = select_hashes(response_purchases['data'], 'user_id', user.first['id'])
        spendings = map_hash_value(purchases, 'spend')
        if spendings.empty?
          puts 0 # User has not spent anything
        else
          puts spendings.map(&:to_i).sum
        end
      end
    when 'most_loyal'
      response            = ApiClient.get('/purchases')
      response_users      = ApiClient.get('/users')
      user_id_with_most_purchases = highest_count(response['data'], 'user_id')
       # Would have been nice to have a API endpoint where you can get a user by id. GET /users/:id
      user_with_most_purchases = response_users['data'].find { |user| user['id'] == user_id_with_most_purchases }
      puts user_with_most_purchases['email']
    else
      puts 'NEED ARGUMENTS'
    end
  end
end

DriftRockCli.execute(ARGV)
