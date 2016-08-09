class Node
  attr_accessor :parent
  attr_accessor :next
  attr_reader :nested_nodes

  def initialize(parent = nil, next_node = nil)
    @parent = parent
    @next = next_node
    set_default_values
  end

  def has_next?
    !@next.nil?
  end

  def has_parent?
    !!@parent
  end

  def has_nested?
    @nested_nodes.length > 0
  end

  def add_nested_node(node)
    @nested_nodes.push(node)
  end

  private

  def set_default_values()
    @nested_nodes = []
  end
end