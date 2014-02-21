# hangman_spec.rb
# cmd: "C:\Users\Hanna\Documents\Ruby\Hangman>rspec spec"

require_relative 'spec_helper.rb'

describe Hangman do

  before :each do
    @play = Hangman.new "test_words.txt"
  end

  shared_examples "no guesses made" do |initial_output|
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

  shared_examples "both correct/incorrect guesses" do |correct_guesses, incorrect_guesses, expected_output|
    context "#{correct_guesses.size} correct guesses, and #{incorrect_guesses.size} incorrect guesses" do
      it "contains #{expected_output}" do
        @play.guesses = incorrect_guesses + correct_guesses
        subject.should eql expected_output
      end
    end
  end

  describe "#choose_word" do
    it "is 'ruby'" do
      @play.choose_word("test_words.txt").should eql %w{r u b y}
    end
  end

  describe "#draw_gallow" do
  end

  describe "#get_right_guesses" do
    subject {@play.get_right_guesses}
    it_behaves_like "no guesses made", %w{- - - -}
    it_behaves_like "correct guesses made", %w{r u b}, %w{r u b -}
    it_behaves_like "incorrect guesses made", %w{a c d e}, %w{- - - -}
    it_behaves_like "both correct/incorrect guesses", %w{b u y}, %w{m i n}, %w{- u b y}
  end

  describe "#get_frames" do
    it "returns an array" do
      @play.get_frames.should be_an_instance_of Array
    end
    it "returns an array of size 12" do
      @play.get_frames.size == 12
    end
  end

  describe "#get_wrong_guesses" do
    subject {@play.get_wrong_guesses}
    it_behaves_like "no guesses made", []
    it_behaves_like "correct guesses made", %w{r u b}, []
    it_behaves_like "incorrect guesses made", %w{a c d e}, %w{a c d e}
    it_behaves_like "both correct/incorrect guesses", %w{b u y}, %w{m i n}, %w{m i n}
  end

  describe "#guess_letter" do
    context "when no guesses" do
      it "returns an empty array" do
        @play.guesses.size.should eql 0
      end
    end

    context "when one guess" do
      it "returns an array of size 1" do
        @play.guess_letter "a"
        @play.guesses.size.should eql 1
      end
    end
  end

  describe "#guesses_left" do
    subject {@play.guesses_left}
    it_behaves_like "no guesses made", 11
    it_behaves_like "correct guesses made", %w{r u b}, 11
    it_behaves_like "incorrect guesses made", %w{a c d e}, 7
    it_behaves_like "both correct/incorrect guesses", %w{b u y}, %w{m i n}, 8
  end

  describe "#is_valid?" do
    it "tests if input is valid" do
      {"a" => true, "H" => true, "ff" => false, "-" => nil, 6 => nil}.each do |input, validity|
        @play.is_valid?(input).should == validity
      end
    end
  end

  describe "#lose?" do
    subject {@play.lose?}
    it_behaves_like "no guesses made", false
    it_behaves_like "correct guesses made", %w{r u b}, false
    it_behaves_like "incorrect guesses made", %w{a c d e}, false
    it_behaves_like "incorrect guesses made", %w{a c d e q w z x p l m}, true
    it_behaves_like "both correct/incorrect guesses", %w{r u b y}, %w{m i n}, false
    it_behaves_like "both correct/incorrect guesses", %w{r u b}, %w{a c d e q w z x p l m}, true
  end

  describe "#new" do
    it "creates an instance of the Hangmanclass" do
      @play.should be_an_instance_of Hangman
    end
  end

  describe "#new_guess?" do
    context "new guess is passed" do
      it "returns true" do
        @play.new_guess?("l").should eql true
      end 
    end

    context "3 guesses made, second guess passed again" do
      it "returns false" do
        @play.guesses = %w{w e r}
        @play.new_guess?("e").should eql false
      end
    end
  end

  describe "#win?" do
    subject {@play.win?}
    it_behaves_like "no guesses made", false
    it_behaves_like "correct guesses made", %w{r u b}, false
    it_behaves_like "correct guesses made", %w{r u b y}, true
    it_behaves_like "incorrect guesses made", %w{a c d e}, false
    it_behaves_like "both correct/incorrect guesses", %w{r u b y}, %w{m i n}, true
    it_behaves_like "both correct/incorrect guesses", %w{r u b}, %w{a c d e q w z x p l m}, false
  end
end