class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      hash = key.hash 
      self[hash] << key
      @count += 1 
      resize! if @count == num_buckets
    end
  end

  def include?(key)
    hash = key.hash 
    self[hash].include?(key)
  end

  def remove(key)
    hash = key.hash 
    @count -= 1 if self[hash].delete(key)
  end

  private

  def [](num)  
    @store[num  % num_buckets ]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) {Array.new}
    @store.each do |bucket|
      bucket.each do |el|
        hash = el.hash
        new_store[hash % new_store.length] << el 
      end 
    end 
    @store = new_store
  end
end
