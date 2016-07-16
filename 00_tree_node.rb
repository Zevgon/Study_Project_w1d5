require "byebug"

class PolyTreeNode
  attr_accessor :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    if node == nil
      @parent.children.delete(self)
      @parent = nil
    else
      @parent.children.delete(self) unless @parent.nil?
      @parent = node
      @parent.children << self
    end

  end

  def add_child(node)
    node.parent = self unless @children.include?(node)
  end

  def remove_child(node)
    node.parent = nil
    @children.delete(node)
  end

  def dfs(value)
    return self if @value == value
    return nil if @children.empty?
    i = 0
    while i < @children.length
      found = @children[i].dfs(value)
      return found unless found.nil?
      i += 1
    end
  end

  def bfs(value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      puts node.value
      if node.value == value
        return node
      else
        found = node.children.select {|node2| node2.value == value }[0]
        if found
          puts "Found #{found.value}"
          return found
        else
          queue += node.children
        end
      end
    end

    nil
  end

end
