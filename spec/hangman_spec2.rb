# hangmanclass_spec.rb

require_relative "spec_helper.rb"

describe Hangman do
  before :each do
    @play = Hangman.new
  end

  describe "#new" do
    it "takes one argument and returns an instance of the Hangman class" do
      @play.should be_an_instance_of Hangman
    end
  end

  describe "#guesses" do
  	context "no guesses made" do
      it "returns an empty array" do
        expect(@play.guesses).to be_an_instance_of(Array)
        expect(@play.guesses.size).to eql(0)
      end
    end

    context "one guess made" do
      it "returns an array of size 1" do
        @play.guess_letter("a")
        expect(@play.guesses).to be_an_instance_of(Array)
        expect(@play.guesses.size).to eql(1)
      end
  	end
  end

  describe "#guesses_left" do
    context "no guesses made" do
      it "returns a Fixnum of size 11" do
        expect(@play.guesses_left).to be_an_instance_of(Fixnum)
        expect(@play.guesses_left).to eql(11)
      end
    end

    context "one incorrect guess made" do
      it "returns a Fixnum of size 10" do
        @play.guess_letter("h")
        expect(@play.guesses_left).to be_an_instance_of(Fixnum)
        expect(@play.guesses_left).to eql(10)
      end
    end

        context "one correct guess made" do
          it "returns a Fixnum of size 11" do
            @play.guess_letter("a")
            expect(@play.guesses_left).to be_an_instance_of(Fixnum)
            expect(@play.guesses_left).to eql(11)
      end
    end
  end

  describe "#secret_word" do
    it "returns an Array of size greater or equal to 3" do
      @play.secret_word.should be_an_instance_of Array
      expect(@play.secret_word.size).to be >= 3
    end
  end

  describe "#gallow_pics" do
    context "no guesses made" do
      it "returns an array of size 8" do
        @play.secret_word.should be_an_instance_of Array
        @play.gallow_pics[0].size.should eql 8
      end
    end

    context "4 incorrect guesses made" do
      it "returns an array of size 56" do
        @play.secret_word.should be_an_instance_of Array
        @play.gallow_pics[4].size.should eql 56
      end
    end
  end

  describe "#already_guessed?" do
    context "one guess has already been made, and the same guess is passed again" do
      it "returns true" do
        @play.guess_letter("s")
        expect(@play.already_guessed?("s")).to eql true
      end 
    end

    context "three guesses have already been made, and the second guess is passed again" do
      it "returns true" do
        @play.guess_letter("w")
        @play.guess_letter("e")
        @play.guess_letter("r")
        expect(@play.already_guessed?("e")).to eql true
      end
    end

    context "one guess has been made, and a new guess is passed" do
      it "returns false" do
        @play.guess_letter("o")
        expect(@play.already_guessed?("v")).to eql false
      end
    end
  end

  describe "#choose_word" do
    it "returns a random word in an array" do
      expect(@play.choose_word("words.txt")).to be_an_instance_of Array
    end
  end
end