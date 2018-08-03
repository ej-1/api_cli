require './helpers/iterator_helper'
require './lib/api_client.rb'

class DriftrockCli
  extend IteratorHelper

  def self.execute(args)
    case args[0]
    when 'most_sold'
      response = self.handle_response(ApiClient.get('/purchases')) # TRY TO WRITE A HOOK METHOD INSTEAD
      result   = most_sold(response['data'])
      log(result)
    when 'total_spend' # ruby app.rb total_spend schimmel_quincy@ernser.io 
      user_email = args[1]
      if user_email.empty?
        log('Need a user email.')
      else
        response_users = self.handle_response(ApiClient.get('/users'))
        response_purchases = self.handle_response(ApiClient.get('/purchases'))
        result = total_spend(response_users['data'], response_purchases['data'], user_email)
        log(result)
      end
    when 'most_loyal'
      response_purchases  = self.handle_response(ApiClient.get('/purchases'))
      response_users      = self.handle_response(ApiClient.get('/users'))
      result = most_loyal(response_users['data'], response_purchases['data'])
      log(result)
    else
      puts 'Wrong arguments! valid options. most_sold, total_spend, most_loyal'
    end
  end

  # need to test test this
  def self.handle_response(response)
    if response.first.nil?
      log(response)
      exit!
    else
      response.first
    end
  end

  def self.log(input)
    puts input
  end

  def self.most_sold(users)
    highest_count(users, 'item')
  end

  def self.total_spend(response_users, response_purchases, user_email)
    user = select_hashes(response_users, 'email', user_email)
    if user.empty?
      # should the output maybe be JSON?
      'No user found with that email.'
    else
      purchases = select_hashes(response_purchases, 'user_id', user.first['id'])
      spendings = map_hash_value(purchases, 'spend')
      if spendings.empty?
        0.0
      else
        spendings.map(&:to_f).sum
      end
    end
  end

  def self.most_loyal(response_users, response_purchases)
    user_id_with_most_purchases = highest_count(response_purchases, 'user_id')
     # Would have been nice to have a API endpoint where you can get a user by id. GET /users/:id
    user_with_most_purchases = response_users.find { |user| user['id'] == user_id_with_most_purchases }
    user_with_most_purchases['email']
  end
end
