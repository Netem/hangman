# play_hangman.rb

# Lacks support for missing files

require_relative "hangman.rb"

class PlayHangman
  attr_accessor :play

  def initialize
    @play = Hangman.new
  end

  def get_input
    gets.to_s.chomp.downcase
  end

  def give_intro
    puts "Let's hang the man!\nI'll pick a word, you guess a letter."
  end

  def print_info
    puts play.draw_gallow
    puts play.get_right_guesses.join
    puts "Wrong: #{play.get_wrong_guesses.join}"
    puts "\n\n"
  end

  def check(guess)
    unless play.new_guess? guess
      puts "Already guessed!\n"
      return
    end

    unless play.is_valid? guess
      puts "Not valid. Try again!\n"
      return
    end

    play.guess_letter guess
		print_info

    if play.lose?
      puts "You lose! I win! Yay! The right word was #{play.secret_word.join}!"
    end

    if play.win?
      puts "You win... Alright. Fine. I want a rematch!"
    end

  end

  def self.run
    game = PlayHangman.new
    game.give_intro

    begin
      print "Your guess: "
      guess = game.get_input
      game.check guess
    end until game.play.win? || game.play.lose?
  end
end