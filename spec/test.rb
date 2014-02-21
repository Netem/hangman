# test.rb

require_relative 'spec_helper.rb'

describe Hangman do

  before :each do
    @play = Hangman.new("test_words.txt")
  end

  shared_examples "no guesses made" do |expected_class, initial_output|

    it "returns a/n #{expected_class}" do
      subject.should be_an_instance_of Array
    end
    it "contains #{initial_output}" do
      subject.should eql initial_output
    end
  end

  shared_examples "correct guesses made" do |correct_guesses, expected_output|
    context "#{correct_guesses.size} correct guesses" do
      it "contains #{expected_output}" do
        @play.guesses = correct_guesses
        subject.should eql expected_output
      end
    end
  end

  shared_examples "incorrect guesses made" do |incorrect_guesses, expected_output|
    context "#{incorrect_guesses.size} incorrect guesses" do
      it "contains #{expected_output}" do
        @play.guesses = incorrect_guesses
        subject.should eql expected_output
      end
    end
  end

  shared_examples "both incorrect/correct guesses" do |correct_guesses, incorrect_guesses, expected_output|
    context "#{correct_guesses.size} correct guesses, and #{incorrect_guesses.size} incorrect guesses" do
      it "contains #{expected_output}" do
        @play.guesses = incorrect_guesses + correct_guesses
        subject.should eql expected_output
      end
    end
  end

  describe "#get_right_guesses" do
    subject {@play.get_right_guesses}
    it_behaves_like "no guesses made", "Array", %w{- - - -}
    it_behaves_like "correct guesses made", %w{r u b}, %w{r u b -}
    it_behaves_like "incorrect guesses made", %w{a c d e}, %w{- - - -}
    it_behaves_like "incorrect/correct guesses", %w{b u y}, %w{m i n}, %w{- u b y}
  end
end