# hangmanclass.rb

class Hangman
   attr_accessor :guesses, :guesses_left, :gallow_pics, :secret_word
   NUM_GUESSES = 11


   def initialize(file)
      @secret_word = choose_word(file)
      @guesses = []
      @guesses_left = NUM_GUESSES
      @gallow_pics = get_frames
   end

   def already_guessed?(letter)
      guesses.include? letter
   end

   def choose_word(file)
      f = File.open(file)
      word_list = f.read.split(" ")
      f.close
      word_list[rand(word_list.size)].chomp.scan(/./) # Chooses a random word from the word list, and puts each letter into an array
   end

   def draw_gallow
      gallow_pics[get_wrong_guesses.size] # Picks the pic based on how many faulty guesses the user's made
   end

   def get_right_guesses
      @secret_word.map{|char| @guesses.include?(char) ? char : "-"} # Returns an array with the correct guessed letters
   end

   def get_wrong_guesses
      @guesses - @secret_word # Returns an array with the wrong guessed letters
   end

   def guess_letter(letter) 
      guesses.push(letter)
      update_guesses_left
   end

   def get_frames
     frames = Dir.entries("ascii_frames").sort
     frames.delete(".")
     frames.delete("..")
     frames.map {|ascii| f = open("./ascii_frames/#{ascii}"); f.read} # Can't close f, because only the last value is returned
   end

   def update_guesses_left
      @guesses_left = NUM_GUESSES - get_wrong_guesses.length
   end
end