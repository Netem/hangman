# hangman_spec.rb
# cmd: "C:\Users\Hanna\Documents\Ruby\Hangman>rspec spec"

require_relative 'spec_helper.rb'

describe Hangman do

  def before_any_guess method_name, expected_class, expected_content
    @play = Hangman.new "spec\\test_words.txt"

    it "#{method_name} is #{expected_class}" do
      @play.method_name.should be_an_instance_of expected_class
    end
    it "#{method_name} returns #{expected_content}" do
      @play.method_name.should eql expected_content
    end
  end

  describe "#choose_word" do
    before_any_guess "secret_word", Array, %w{- - - -}
  end
end

  describe "#draw_gallow" do
    it "returs an array" do
      @play.draw_gallow.should be_an_instance_of Array
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