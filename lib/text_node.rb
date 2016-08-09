class TextNode < Node
  attr_reader :text

  def push(char)
    @text += char
  end

  def add_nested_node(node)
    @nested_nodes.push(node)
  end

  private

  def set_default_values()
    super
    @text = ''
  end

end