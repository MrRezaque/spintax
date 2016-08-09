require_relative '../lib/tree_builder'

describe TreeBuilder do
  describe "#build_tree" do
    it "fails on wrong bracket sequence" do
      expect {TreeBuilder.new.build_tree('}')}.to raise_error(StandardError)
      expect {TreeBuilder.new.build_tree('{')}.to raise_error(StandardError)
      expect {TreeBuilder.new.build_tree('|')}.to raise_error(StandardError)
    end

    it "doesn't fails on right bracket sequence" do
      expect {TreeBuilder.new.build_tree('asd')}.to_not raise_error
      expect {TreeBuilder.new.build_tree('asd{}')}.to_not raise_error
      expect {TreeBuilder.new.build_tree('asd{a|b}')}.to_not raise_error
      expect {TreeBuilder.new.build_tree('asd{a|b}asd')}.to_not raise_error
      expect {TreeBuilder.new.build_tree('asd{a{asd|asd}b}asd')}.to_not raise_error
      expect {TreeBuilder.new.build_tree('asd{a{asd|asd}|b}asd')}.to_not raise_error
    end
  end
end