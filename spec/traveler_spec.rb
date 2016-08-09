require_relative '../lib/spintax'
require_relative '../lib/tree_builder'

describe Spintax do
  describe "#explore_node" do
    it "doesn't fail on correct input" do
      expect{Spintax.print_spintax(TreeBuilder.new.build_tree("aaa{bbb|ccc|{ddd|eee}}"))}.to_not raise_error
    end

    it "works as expected on plain phrase" do
      expect(STDOUT).to receive(:puts).with('aaa')
      Spintax.print_spintax(TreeBuilder.new.build_tree("aaa"))
    end

    it "shows text before fork" do
      expect(STDOUT).to receive(:puts).with('aaabbb')
      expect(STDOUT).to receive(:puts).with('aaaccc')
      Spintax.print_spintax(TreeBuilder.new.build_tree("aaa{bbb|ccc}"))
    end

    it "shows text after fork" do
      expect(STDOUT).to receive(:puts).with('bbbaaa')
      expect(STDOUT).to receive(:puts).with('cccaaa')
      Spintax.print_spintax(TreeBuilder.new.build_tree("{bbb|ccc}aaa"))
    end

    it "works as expected on 1st lvl nested spintax" do
      expect(STDOUT).to receive(:puts).with('a')
      expect(STDOUT).to receive(:puts).with('b')
      expect(STDOUT).to receive(:puts).with('c')
      Spintax.print_spintax(TreeBuilder.new.build_tree("{a|b|c}"))
    end

    it "works as expected with several same lvl spintax" do
      expect(STDOUT).to receive(:puts).with('ac')
      expect(STDOUT).to receive(:puts).with('ad')
      expect(STDOUT).to receive(:puts).with('bc')
      expect(STDOUT).to receive(:puts).with('bd')
      Spintax.print_spintax(TreeBuilder.new.build_tree("{a|b}{c|d}"))
    end

    it "works as expected on 2st lvl nested spintax" do
      expect(STDOUT).to receive(:puts).with('a')
      expect(STDOUT).to receive(:puts).with('a')
      expect(STDOUT).to receive(:puts).with('b')
      expect(STDOUT).to receive(:puts).with('a')
      Spintax.print_spintax(TreeBuilder.new.build_tree("{a|{a|b}|a}"))
    end

    it "works as expected on 2st lvl nested spintax and nested text before fork" do
      expect(STDOUT).to receive(:puts).with('aaabbb')
      expect(STDOUT).to receive(:puts).with('aaaccc')
      expect(STDOUT).to receive(:puts).with('aaafffddd')
      expect(STDOUT).to receive(:puts).with('aaafffeee')
      Spintax.print_spintax(TreeBuilder.new.build_tree("aaa{bbb|ccc|fff{ddd|eee}}"))
    end

    it "works as expected on 2st lvl nested spintax and nested text after fork" do
      expect(STDOUT).to receive(:puts).with('aaabbb')
      expect(STDOUT).to receive(:puts).with('aaaccc')
      expect(STDOUT).to receive(:puts).with('aaadddfff')
      expect(STDOUT).to receive(:puts).with('aaaeeefff')
      Spintax.print_spintax(TreeBuilder.new.build_tree("aaa{bbb|ccc|{ddd|eee}fff}"))
    end

    it "works with pokemon example" do
      INCOMING_STRING = "I really like to {be inside and {play computer|read a book|watch tv}|be outside {and|where I like to} {play football|take a walk|catch pokemon}}"
      expect(STDOUT).to receive(:puts).with('I really like to be inside and play computer')
      expect(STDOUT).to receive(:puts).with('I really like to be inside and read a book')
      expect(STDOUT).to receive(:puts).with('I really like to be inside and watch tv')
      expect(STDOUT).to receive(:puts).with('I really like to be outside where I like to play football')
      expect(STDOUT).to receive(:puts).with('I really like to be outside where I like to take a walk')
      expect(STDOUT).to receive(:puts).with('I really like to be outside where I like to catch pokemon')
      expect(STDOUT).to receive(:puts).with('I really like to be outside and play football')
      expect(STDOUT).to receive(:puts).with('I really like to be outside and take a walk')
      expect(STDOUT).to receive(:puts).with('I really like to be outside and catch pokemon')
      Spintax.print_spintax(TreeBuilder.new.build_tree(INCOMING_STRING))
    end
  end
end