# hangman_spec.rb
# cmd: "C:\Users\Hanna\Documents\Ruby\Hangman>rspec spec"

require_relative 'spec_helper.rb'

describe Hangman do
  before :each do
    @play = Hangman.new "test_words.txt"
  end

  describe "#new" do
    it "creates an instance of the Hangmanclass" do
      @play.should be_an_instance_of Hangman
    end
  end


  describe "#choose_word" do
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

  describe "@gallow_pics" do
    it "returns an array" do
      @play.gallow_pics.should be_an_instance_of Array
    end
    it "returns an array of size 12" do
      @play.gallow_pics.size == 12
    end
  end


  describe "#get_frames" do
    it "returns an array" do
      @play.get_frames.should be_an_instance_of Array
    end
    it "returns an array of size 12" do
      @play.get_frames.size == 12
    end
  end


  describe "#get_right_guesses" do
    it "returns an array" do
      @play.get_right_guesses.should be_an_instance_of Array
    end

    context "when no guesses" do
      it "returns an array consisting of '-'" do
        @play.get_right_guesses.include? "-"
      end

      it "returns an array of size 4" do
        @play.get_right_guesses.size.should eql 4
      end
    end

    context "when 1 correct guess" do
      it "returns an array with the correct guessed letter" do
        @play.guess_letter "r"
        @play.get_right_guesses.include? "r"
      end
      it "returns an array of size 4" do
        @play.guess_letter "r"
        @play.get_right_guesses.size.should eql 4
      end
    end
  end


  describe "#get_wrong_guesses" do
    it "returns an array" do
      @play.get_wrong_guesses.should be_an_instance_of Array
    end

    context "when no guesses" do
      it "returns an array of size 0" do
        @play.get_wrong_guesses.size.should eql 0
      end
    end

    context "when 1 incorrect guess" do
      it "returns the incorrect letter" do
        @play.guess_letter("h")
        @play.get_wrong_guesses.include? "h"
      end
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
    it "returns a Fixnum" do
      @play.guesses_left.should be_an_instance_of Fixnum
    end

    context "when no guesses" do
      it "returns 11" do
        @play.guesses_left.should eql 11
      end
    end

    context "when two correct guesses" do
      it "returns 11" do
        @play.guesses = %w{r y}
        @play.guesses_left.should eql 11
      end
    end

    context "when two incorrect guesses" do
      it "returns 9" do
        @play.guesses = %w{q w}
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
    context "when 10 incorrect guesses and 3 correct guesses" do
      it "returns false" do
        @play.guesses = %w{r u b q w e a s d z x c v}
        @play.lose?.should eql false
      end
    end

    context "when 11 incorrect guesses and 3 correct guesses" do
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
        @play.guesses = %w{w e r}
        @play.new_guess?("e").should eql false
      end
    end
  end


  describe "#win?" do
    context "when 10 incorrect guesses and 3 correct guesses" do
      it "returns false" do
        @play.guesses = %w{r u b q w e a s d z x c v}
        @play.win?.should eql false
      end
    end

    context "when 10 incorrect guesses and 4 correct guesses" do
      it "returns true" do
        @play.guesses = %w{r u b q w e a s d z x c v p y}
        @play.win?.should eql true
      end
    end
  end
end