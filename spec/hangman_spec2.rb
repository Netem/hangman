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