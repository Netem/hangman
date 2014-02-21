# hangman.rb

class Hangman
  attr_accessor :gallow_pics, :guesses, :secret_word
  NUMBER_OF_GUESSES = 11

  def initialize file_name = "words.txt"
    @secret_word = choose_word file_name
    @guesses = []
    @gallow_pics = get_frames
  end

  def choose_word file_name
    file = open Dir.glob("#{file_name}").join
    word_list = file.read.split " "
    file.close
    word_list[rand(word_list.size)].chomp.scan(/./) # Chooses a random word from the word list, and puts each letter into an array
  end

  def draw_gallow
    gallow_pics[get_wrong_guesses.size] # Picks the pic based on how many faulty guesses the user's made
  end

  def get_frames
    frames = Dir.glob("ascii_frames/*").sort
    frames.map do |ascii| 
      open(ascii) do |file|
        file.read
      end
    end
  end

  def get_right_guesses
    @secret_word.map{|char| @guesses.include?(char) ? char : "-"} # Returns an array with the correct guessed letters
  end

  def get_wrong_guesses
    @guesses - @secret_word # Returns an array with the wrong guessed letters
  end

  def guess_letter letter
    guesses.push letter
  end

  def guesses_left
    NUMBER_OF_GUESSES - get_wrong_guesses.length
  end

  def is_valid? guess
    guess =~ /[[:alpha:]]/ && guess.length == 1
  end

  def lose?
    guesses_left < 1
  end

  def new_guess? letter 
    not guesses.include? letter
  end

  def win?
    @secret_word.eql? get_right_guesses
  end
end