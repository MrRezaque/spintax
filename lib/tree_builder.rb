require_relative 'node'
require_relative 'text_node'

class TreeBuilder
  def initialize
    @consistency_stack = []
    @root_element = TextNode.new
    @current_node = @root_element
  end

  def build_tree(input_string)
    input_string.each_char do |char|
      process_char(char)
    end
    completeness_check!
    @root_element
  end

  def process_char(char, node = nil)
    case char
      when '{' then
        @consistency_stack.push('{')

        # create new node and add it to graph
        # append new node start
        new_node = Node.new
        new_node.parent = @current_node.parent
        @current_node.next = new_node
        # append new node end

        # mark added node as current
        @current_node = new_node

        # append new textnode to current node
        new_text_node = TextNode.new
        new_text_node.parent = @current_node
        @current_node.add_nested_node(new_text_node)
        # append new textnode to current node end

        # make current node point to the appended textnode
        @current_node = new_text_node
      when '}'
        #check if corresponding { appered in stack before
        character_correctness_check!(char)

        # up to hierarchy
        @current_node = @current_node.parent

        # make new node to be next after current
        new_text_node = TextNode.new
        new_text_node.parent = @current_node.parent
        @current_node.next = new_text_node

        # mark added node as a current
        @current_node = new_text_node
      when '|'
        # "|" symbol makes sence only inside {}
        character_correctness_check!(char)

        #up to hierarchy
        @current_node = @current_node.parent

        # append new textnode to it
        new_text_node = TextNode.new
        new_text_node.parent = @current_node
        @current_node.add_nested_node(new_text_node)

        # make current node point to the appended textnode
        @current_node = new_text_node
      else
        @current_node.push(char)
      end
  end

  private

  def character_correctness_check!(char)
    # "|" and  "}" must  be inside opened {
    if @consistency_stack.length < 1
      raise 'IncorrectCharacterSequence'
    end
    if char == '}'
      @consistency_stack.pop
    end
  end

  def completeness_check!
    if @consistency_stack.length > 0
      raise 'IncorrectCharacterSequence'
    end
  end
end