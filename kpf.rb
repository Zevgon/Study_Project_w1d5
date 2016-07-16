require 'byebug'
require './00_tree_node.rb'

class Kpf
  attr_accessor :root

  def initialize(pos)
    @pos = pos
    @board = Array.new(8) { (0..7).to_a }
    @visited_positions = [pos]
    @root = PolyTreeNode.new(pos)
  end

  def self.valid_moves(pos)
    x, y = pos
    all = [[x + 1, y + 2], [x + 1, y - 2], [x - 1, y + 2], [x - 1, y - 2],
    [x + 2, y + 1], [x + 2, y - 1], [x - 2, y + 1], [x - 2, y - 1]]
    all.reject { |pos| !pos[0].between?(0, 7) || !pos[1].between?(0,7) }
  end

  def new_move_positions(pos)
    moves = Kpf.valid_moves(pos)
    moves -= @visited_positions
    @visited_positions += moves
    return moves
  end

  def build_move_tree
    queue = [@root]
    until queue.empty?
      current_root = queue.shift
      level = new_move_positions(current_root.value)
      level.each do |position|
        node = PolyTreeNode.new(position)
        node.parent = current_root
        queue << node
      end
    end
    nil
  end

  def find_path(end_pos)
    # byebug
    target = @root.bfs(end_pos)
    path = []
    until target.parent.nil?
      path << target.value
      target = target.parent
    end

    path.reverse
  end

end

if __FILE__ == $PROGRAM_NAME
  a = Kpf.new([0, 0])
  a.build_move_tree
  p a.find_path([6, 2])
end
