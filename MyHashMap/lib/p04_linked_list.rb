class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable
  
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail 
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    return true if @head.next == @tail
    false
  end

  def get(key)
    return nil unless include?(key)
    find_node(key).val 
  end

  def include?(key)
    return true if find_node(key)
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = @tail.prev
    @tail.prev.next = new_node
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
    return if empty?
    find_node(key).val = val
  end

  def remove(key)
    find_node(key).remove
  end

  def each(&prc)
    node = @head.next
    while node != @tail 
      prc.call(node)
      node = node.next  
    end
  end
  
  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
  
  private 
  
  def find_node(key)
    check_node = @head.next
    until check_node == @tail
      return check_node if check_node.key == key
      check_node = check_node.next
    end 
    nil 
  end

end
