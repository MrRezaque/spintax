require_relative('lib/spintax')
require_relative('lib/node')
require_relative('lib/text_node')
require_relative('lib/tree_builder')

input_text = IO.read('data/input.txt')
tree_root = TreeBuilder.new.build_tree(input_text)
$stdout.reopen('data/output.txt', "w")
Spintax.print_spintax(tree_root)

