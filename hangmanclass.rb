# hangmanclass.rb

class Hangman
   attr_accessor :guesses, :guesses_left, :gallow_pics, :secret_word

   def initialize(file)
      @secret_word = choose_word(file)
      @guesses = Array.new
      @guesses_left = 11
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
      gallow_pics[get_wrong_guesses.size]
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
      frames = Array.new
      for i in 1..12
         file = open("./ascii_frames/frame_#{i}.txt")
         frames.push file.read
         file.close
      end
      return frames
   end

   def update_guesses_left
      @guesses_left = 11 - get_wrong_guesses.length
   end
end