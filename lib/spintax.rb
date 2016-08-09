require_relative('node')
require_relative('text_node')

module Spintax
  def self.print_spintax(node)
    explore_node(node, '')
  end

  def self.explore_node(node, str)
    # puts node.has_nested?
    #firstly check if node has nested nodes, if so, jump to each with current string value
    if node.has_nested?
      node.nested_nodes.each { |nested_node| explore_node(nested_node, str) }
      return
    end

    # if it doesn't have nested, then just grab a text and move on
    new_str = "#{str}#{node.text}"
    current_node = node
    while !current_node.has_next? && current_node.has_parent? #figure out if we can go up to hierarchy
      # p current_node.class
      current_node = current_node.parent
    end

    # when it is topmost node and didn't have next node
    if current_node.nil? || !current_node.has_next?
      show_string(new_str)
      return
    end

    #move to next node
    explore_node(current_node.next, new_str)
  end

  def self.show_string(str)
    puts str
  end
end