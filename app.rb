require './lib/api_client.rb'
require './helpers/iterator_helper'
require 'benchmark'
require 'pry'

# 25 000 times slower
def merge(array)
  user_ids = array.map do |hash|
    hash['user_id']
  end
  new_hash = Hash.new
  user_ids.each do |user_id|
    # remember to REMOVE user_ids
    new_hash[user_id] = array.select { |hash| hash['user_id'] == user_id }
  end
  return new_hash
end





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
        # NEW SEARCHT ALGO
=begin
        puts Benchmark.measure {
          new_json = merge(response_purchases['data'])
          user_purchases = new_json[user.first['id']]
        }

        new_json = merge(response_purchases['data'])
        user_purchases = new_json[user.first['id']]

        puts Benchmark.measure {
          purchases = select_hashes(response_purchases['data'], 'user_id', user.first['id'])
        }
=end
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





#array = ApiClient.get('/purchases')
#puts merge(array['data'])


puts Benchmark.measure {
  DriftRockCli.execute(ARGV)
}







=begin
➜  driftrock_api git:(master) ✗ ruby app.rb total_spend travis_kshlerin@wunsch.net
333
  0.100000   0.030000   0.130000 (  0.674347)
➜  driftrock_api git:(master) ✗ ruby app.rb total_spend travis_kshlerin@wunsch.net
^[[A333
  0.090000   0.010000   0.100000 (  0.432844)
➜  driftrock_api git:(master) ✗ ruby app.rb total_spend travis_kshlerin@wunsch.net
333
  0.090000   0.010000   0.100000 (  0.483813)
=end