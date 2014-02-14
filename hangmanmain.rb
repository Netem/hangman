# hangmanmain.rb

# Mistakes: 1) gets input for y/n contained a \n, so the comparision to %w{y yes} was always false
# 2) used || instead of "or"
# 3) missing session.<command>

# Unstable version - lacks support for missing files

require_relative "hangmanclass.rb"

class PlayHangman
  attr_accessor :file, :play

  def initialize
    @file = "words.txt"
    @play = Hangman.new(@file)
  end

  def give_intro
    puts "Let's hang the man!\nI'll pick a word, you guess a letter."
  end

  def get_input
    gets.to_s.chomp.downcase
  end

  def print_info
    puts play.draw_gallow
    puts play.get_right_guesses.join
    puts "Wrong: #{play.get_wrong_guesses.join}"
    puts "\n\n"
  end

  def play_the_game(guess)
    if play.already_guessed? guess
      puts "Already guessed!"
      return
    end

    unless guess =~ /[[:alpha:]]/ && guess.length == 1
      puts "Not valid. Try again!\n"
      return
    end

    play.guess_letter(guess)
		print_info

    if play.guesses_left < 1
      puts "You lose! I win! Yay! The right word was #{play.secret_word.join}!"
    end

    if play.secret_word.eql? play.get_right_guesses
      puts "You win... Alright."
    end

  end

  def self.run
    session = PlayHangman.new
    session.give_intro

    begin
      print "Your guess: "
      guess = session.get_input
      session.play_the_game(guess)
    end until session.play.secret_word.eql? session.play.get_right_guesses or session.play.guesses_left < 1
  end
end