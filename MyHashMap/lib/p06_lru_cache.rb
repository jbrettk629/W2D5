require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # uses key to find node
    # return node.val
    # get should call the given prc for uncached inputs
    
    # uncached input: not in @map
    if @map.include?(key)
      node = @map[key]
    else 
      
    
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @prc.call(key)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.remove(node.key) 
    @store.append(node.key, node.val)
  end

  def eject!
    @store.remove(@store.head.prev.key)
  end
end
