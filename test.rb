# test.rb

require_relative "hangman.rb"

a = Hangman.new "words.txt"

a.guesses = %w{q w x z}
puts a.draw_gallow