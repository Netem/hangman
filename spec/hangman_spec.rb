# hangman_spec.rb
# cmd: "C:\Users\Hanna\Documents\Ruby\Hangman>rspec spec"

require_relative 'spec_helper.rb'

describe Hangman do
  before :each do
    @play = Hangman.new "spec\\test_words.txt"
  end

  describe "#new" do
    it "creates an instance of the Hangmanclass" do
      @play.should be_an_instance_of Hangman
    end
  end

  describe "#choose_word" do
    it "@secret_word returns an array" do
      @play.secret_word.should be_an_instance_of Array
    end

    it "@secret_word returns an array of size 4" do
      @play.secret_word.size.should eql 4
    end
  end

  describe "#draw_gallow" do
    context "no guesses made" do
      it "returns an array of size 8" do
        @play.draw_gallow.size.should eql 8
      end
    end

    context "4 incorrect guesses made" do
      it "returns an array of size 56" do
        @play.guess_letter "a"
        @play.guess_letter "c"
        @play.guess_letter "d"
        @play.guess_letter "e"
        @play.draw_gallow.size.should eql 56
      end
    end
  end

  describe "#get_frames" do
    it "@gallow_pics returns an array" do
      @play.gallow_pics.should be_an_instance_of Array
    end
    it "returns an array of size 12" do
      @play.gallow_pics.size.should eql 12
    end
  end

  describe "#get_right_guesses" do
    it "returns an array" do
      @play.get_right_guesses.should be_an_instance_of Array
    end

    context "when no guesses have been made" do
      it "returns an array consisting of '-'" do
        @play.get_right_guesses.include? "-"
      end
    end

    context "when no guesses have been made" do
      it "returns an array of size 4" do
        @play.get_right_guesses.size.should eql 4
      end
    end

        context "1 correct guess made" do
      it "returns an array with the correct guessed letter" do
        @play.guess_letter "r"
        @play.get_right_guesses.include? "r"
      end
    end

    context "when 1 correct guess have been made" do
      it "returns an array of size 4" do
        @play.get_right_guesses.size.should eql 4
      end
    end
  end

  describe "#get_wrong_guesses" do
    it "returns an array" do
      @play.get_wrong_guesses.should be_an_instance_of Array
    end

    context "when no guesses have been made" do
      it "returns an array of size 0" do
        @play.get_wrong_guesses.size.should eql 0
      end
    end

    context "when 1 incorrect guess has been made" do
      it "returns the incorrect letter" do
        @play.guess_letter("h")
        @play.get_wrong_guesses.include? "h"
      end
    end

    context "when 1 incorrect guess has been made" do
      it "returns an array of size 1" do
        @play.guess_letter("h")
        @play.get_wrong_guesses.size.should eql 1
      end
    end
  end

  describe "#guess_letter" do
    it "@guesses returns an array" do
      @play.guesses.should be_an_instance_of Array
    end

    context "when no guesses have been made" do
    	it "returns an empty array" do
    		@play.guesses.size.should eql 0
    	end
    end

    context "when one guess has been made" do
      it "returns an array of size 1" do
        @play.guess_letter "a"
        @play.guesses.size.should eql 1
      end
  	end
  end

  describe "#guesses_left" do
    it "returns a Fixnum" do
      @play.guesses_left.should be_an_instance_of Fixnum
    end

    context "when no guesses have been made" do
      it "returns 11" do
        @play.guesses_left.should eql 11
      end
    end

    context "when two correct guesses have been made" do
      it "returns 11" do
        @play.guess_letter "r"
        @play.guess_letter "y"
        @play.guesses_left.should eql 11
      end
    end

    context "when two incorrect guesses have been made" do
      it "returns 9" do
        @play.guess_letter "q"
        @play.guess_letter "w"
        @play.guesses_left.should eql 9
      end
    end
  end

  describe "#is_valid?" do
    context "when passing A" do
      it "returns true" do
        @play.is_valid?("A").should eql true
      end
    end

    context "when passing z" do
      it "returns true" do
        @play.is_valid?("z").should eql true
      end
    end

    context "when passing _" do
      it "returns nil" do
        @play.is_valid?("_").should be_nil
      end
    end

    context "when passing ff" do
      it "returns false" do
        @play.is_valid?("ff").should eql false
      end
    end

    context "when passing 5" do
      it "returns nil" do
        @play.is_valid?("5").should be_nil
      end
    end
  end

  describe "#lose?" do
    context "when 10 incorrect guesses and 3 correct guesses have been made" do
      it "returns false" do
        @play.guesses = %w{r u b q w e a s d z x c v}
        @play.lose?.should eql false
      end
    end

    context "when 11 incorrect guesses and 3 correct guesses have been made" do
      it "returns true" do
        @play.guesses = %w{r u b q w e a s d z x c v p}
        @play.lose?.should eql true
      end
    end
  end

  describe "#new_guess?" do
    context "a new guess is passed" do
      it "returns true" do
        @play.new_guess?("l").should eql true
      end 
    end

    context "three guesses have already been made, and the second guess is passed again" do
      it "returns false" do
        @play.guess_letter "w"
        @play.guess_letter "e"
        @play.guess_letter "r"
        @play.new_guess?("e").should eql false
      end
    end
  end

  describe "#win?" do
    context "when 10 incorrect guesses and 3 correct guesses have been made" do
      it "returns false" do
        @play.guesses = %w{r u b q w e a s d z x c v}
        @play.win?.should eql false
      end
    end

    context "when 10 incorrect guesses and 4 correct guesses have been made" do
      it "returns true" do
        @play.guesses = %w{r u b q w e a s d z x c v p y}
        @play.win?.should eql true
      end
    end
  end
end