module Enumerable
  # Your code goes here
  def my_each_with_index
    return to_enum(__method__) unless block_given?
      arr = []
      for i in 0..self.length-1 do
        item = yield(self[i], i)
        arr << (item.nil? ? self[i] : item)
      end
      arr
  end

  def my_select
    return to_enum(__method__) unless block_given?
    arr = []
    self.my_each do |element|
      arr << element if yield(element)
    end
    arr
  end

  def my_all?
    return to_enum(__method__) unless block_given?
    arr = []
    self.my_each do |element|
      arr << yield(element)
    end
     arr.my_each_with_index{|item, index| arr[index] = true if !item.nil? && item != false}
    (arr.uniq.length == 1) && arr.uniq[0]
  end
  
  def my_any?
    return to_enum(__method__) unless block_given?
    arr = []
    self.my_each do |element|
      arr << yield(element)
    end
     arr.include? true
  end

  def my_none?
    return to_enum(__method__) unless block_given?
    arr = []
    self.my_each do |element|
      arr << yield(element)
    end
     !arr.include? true
  end

  def my_count
    return self.length unless block_given?
    arr = []
    self.my_each do |element|
      arr << element if yield(element)
    end
     arr.length
  end

  def my_map
    return to_enum(__method__) unless block_given?
    arr = []
    self.my_each do |element|
      arr << yield(element)
    end
    arr
  end

  def my_inject(initial_value)
    return nil unless block_given?
    sum = initial_value
    self.my_each do |element|

    sum = yield(sum, element)
    end
    sum
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    return to_enum(__method__) unless block_given?

    new_array = []
    index = 0
    while index < length
      result = yield(self[index])
      new_array << (result.nil? ? self[index] : result)
      index += 1
    end

    new_array
  end
end

array = [1, 1]

new_arr = array.my_inject(0) {|sum, value| sum + value}

p new_arr