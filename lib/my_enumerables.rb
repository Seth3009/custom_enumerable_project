module Enumerable

  def my_each_with_index
    index = 0
    my_each do |element|
      yield(element, index)
      index += 1
    end
  end

  def my_select
    result = []
    my_each do |element|
      result << element if yield(element)
    end
    result
  end

  def my_all?
    my_each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_any?
    my_each do |element|
      return true if yield(element)
    end
    false
  end

  def my_none?
    result = true
    my_each do |element|
      result = false if yield(element)
    end
    result
  end

  def my_count(&block)
    if block_given?
      select(&block).size
    else
      size
    end
  end

  def my_map(&block)
    return enum_for(:my_map) unless block_given?

    result = []
    each { |element| result << block.call(element) }
    result
  end

  def my_inject(initial = nil)
    array = to_a
    accumulator = initial ? initial : array.shift

    array.each do |value|
      accumulator = yield(accumulator, value)
    end

    accumulator
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    size.times { |i| yield(self[i]) }
    self
  end
end
