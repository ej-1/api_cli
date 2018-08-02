module IteratorHelper
  def highest_count(array, key) # [{"user_id"=>"FFWN-1CKR-X4WU-Q44M", "item"=>"Awesome Marble Clock", "spend"=>"69.44"}, {"user_id"=>"HEI7-W5NW-OO9S-Z382", "item"=>"Synergistic Concrete Pants", "spend"=>"9.87"}, {"user_id"=>"HEI7-W5NW-OO9S-Z382", "item"=>"Synergistic Concrete Pants", "spend"=>"76.06"}, {"user_id"=>"BMCS-1VS1-39KR-7OUM", "item"=>"Durable Wool Shoes", "spend"=  =>  
    item_names      = map_hash_value(array, key)
    items_and_count = count_values(item_names)
    items_and_count.max_by{ |k, v| v }.first
  end

  def map_hash_value(array, key)
    array.map { |h| h[key] }
  end

  # [{:user=>"erik", :pants=>1}, {:user=>"fritz", :pants=>0}]  =>  {:user=>"erik", :pants=>1}
  # user = match_hashes(response_users, 'email', user_email)
  def select_hashes(array, key, searched_value)
    array.select { |h| h[key] == searched_value }
  end

  def count_values(keys)
    count = Hash.new(0)
    keys.each do |key|
      count[key] += 1
    end
    return count
  end
end
