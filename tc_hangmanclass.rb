# tc_hangmanclass.rb

require_relative "hangmanclass"
require "test/unit"

class TestHangmanClass < Test::Unit::TestCase

	def setup
		@hangman_object = Hangman.new("words.txt")
	end

	def test_get_secret_word
		assert_instance_of(Array, @hangman_object.secret_word)
		assert_not_nil(@hangman_object.secret_word)
		# Is every member a lowercase letter?
	end

	def test_get_guesses
		assert_instance_of(Array, @hangman_object.guesses)
		assert_equal(0, @hangman_object.guesses.length)
	end

	def test_get_guesses_left
		assert_equal(11, @hangman_object.guesses_left)
		assert_instance_of(Fixnum, @hangman_object.guesses_left)
	end

	def test_get_gallow_pics
		assert_instance_of(Array, @hangman_object.gallow_pics)
		assert_not_nil(@hangman_object.gallow_pics)
		# How to test if each index contains an array of x signs?
	end
end