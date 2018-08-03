require './helpers/iterator_helper.rb'

describe IteratorHelper do

  before do
    @some_class = Class.new.extend(IteratorHelper)
    @array = [{"key_one"=>"a", "key_two"=>"Clock"},
    {"key_one"=>"b", "key_two"=>"Pants"},
    {"key_one"=>"c", "key_two"=>"Pants"}
   ]
  end

  it '#highest_count' do
    expect(@some_class.highest_count(@array, 'key_two')).to eq('Pants')
  end

  it '#map_hash_value' do
    expect(@some_class.map_hash_value(@array, 'key_two')).
      to eq(["Clock", "Pants", "Pants"])
  end

  it '#count_occurences' do
    array = ["Pants", "Pants", "Clock"]
    expect(@some_class.count_occurences(array)).
      to eq({"Pants" => 2, "Clock" => 1})
  end
end
