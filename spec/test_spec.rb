# test.rb

require_relative 'spec_helper.rb'

describe Hangman do
  before :each do
    @play = Hangman.new "test_words.txt"
  end

  describe "#draw_gallow" do
    it "returs an array" do
      expect(@play.draw_gallow).to be_an_instance_of Array
    end
    context "when no guesses made" do
      it "returns an array of size 8" do
        @play.draw_gallow.size.should == 8
      end
    end
    context "when 4 incorrect guesses" do
      it "returns an array of size 56" do
        @play.guesses = %w{a c d e}
        @play.draw_gallow.size == 56
      end
    end
    context "when 4 incorrect guesses and 3 correct guesses" do
      it "returns an array of size 56" do
        @play.guesses = %w{a c d e r u b}
        @play.draw_gallow.size == 56
      end
    end
  end
end