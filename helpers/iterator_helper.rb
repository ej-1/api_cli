module IteratorHelper
  def highest_count(array, key)
    values               = map_hash_value(array, key)
    occurences_of_values = count_occurences(values)
    occurences_of_values.max_by{ |k, v| v }.first
  end

  def map_hash_value(array, key)
    array.map { |h| h[key] }
  end

  def select_hashes(array, key, searched_value)
    array.select { |h| h[key] == searched_value }
  end

  def count_occurences(array)
    count = Hash.new(0)
    array.each do |element|
      count[element] += 1
    end
    return count
  end
end
