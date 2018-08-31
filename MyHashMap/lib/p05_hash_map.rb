require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end
  
  def include?(key)
    list = bucket(key)
    list.include?(key)
  end

  def set(key, val)
    list = bucket(key)
    if include?(key)
      list.update(key, val)
    else 
      list = bucket(key)
      list.append(key, val)
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def get(key)
    list = bucket(key)
    list.get(key)
  end

  def delete(key)
    @count -= 1 if include?(key)
    list = bucket(key)
    list.remove(key)
  end

  def each(&prc)
    @store.each do |list|
      list.each do |node|
        prc.call(node.key, node.val)
      end 
    end 
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) {LinkedList.new}
    each do |key, val|
        new_list = new_store[key.hash % new_store.length]
        new_list.append(key, val)
    end
    @store = new_store  
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % @store.length]
  end
end
