# tc_hangmanclass.rb

require_relative "hangmanclass"
require "test/unit"

class TestHangmanClass < Test::Unit::TestCase

	def setup
		@hangman_object = Hangman.new("words.txt")
		@hangman_object.guess_letter("a")
		@hangman_object.guess_letter("e")
		@hangman_object.guess_letter("w")
		@hangman_object.guess_letter("x")
	end

	def teardown
		# Empty method shell
	end

	# Test constant
	def test_get_NUM_GUESSES
		assert_instance_of Fixnum, Hangman::NUM_GUESSES
		assert_same 11, Hangman::NUM_GUESSES
	end

	# Test instance variables
	def test_get_secret_word
		assert_instance_of Array, @hangman_object.secret_word
		assert_not_nil @hangman_object.secret_word
		assert_block do @hangman_object.secret_word.each {|char| char.eql?(/[[:alpha:]]/)}
		end
	end

	def test_get_guesses
		assert_instance_of Array, @hangman_object.guesses
		assert_equal 4, @hangman_object.guesses.length
		assert_block do @hangman_object.guesses.each {|char| char.eql?(/[[:alpha:]]/)}
		end
	end

	def test_get_guesses_left
		assert_instance_of Fixnum, @hangman_object.guesses_left
		assert_equal Hangman::NUM_GUESSES - @hangman_object.get_wrong_guesses.size, @hangman_object.guesses_left
	end

	def test_get_gallow_pics
		assert_instance_of Array, @hangman_object.gallow_pics
		assert_not_nil@hangman_object.gallow_pics
		# How to test if each index contains an array of x signs?
	end

	def test_draw_gallow
		# How to test if right picture?
	end

	def test_get_frames
		assert_instance_of Array, @hangman_object.get_frames
		assert_not_nil @hangman_object.get_frames
		assert_equal Hangman::NUM_GUESSES + 1, @hangman_object.get_frames.size
		assert_block do @hangman_object.get_frames.each {|frame| frame.size > 10}
		end

	end

	def test_guess_letter # BAD TEST, YIELD VARIES DEPENDING ON THE secret_word
		assert_equal 4, @hangman_object.guesses.size
		assert_equal 9, @hangman_object.guesses_left
		@hangman_object.guess_letter("nn")
		assert_equal 5, @hangman_object.guesses.size
		assert_equal 8, @hangman_object.guesses_left
	end

	def update_guesses_left
		assert_equal 8, @hangman_object.guesses_left
		@hangman_object.guess_letter("qq") # Any other way than cheating two letters?
		assert_equal 7, @hangman_object.guesses_left
	end

	def test_get_right_guesses
		assert_instance_of Array, @hangman_object.get_right_guesses
		assert_not_nil @hangman_object.get_right_guesses
		assert_block do @hangman_object.get_right_guesses {|char| char.eql?(/[[:alpha:]]/ || /[[-]]/)}
		end
	end

	def test_get_wrong_guesses
		assert_instance_of Array, @hangman_object.get_wrong_guesses
		assert_not_nil @hangman_object.get_wrong_guesses
		assert_block do @hangman_object.get_wrong_guesses {|char| %w{a e w x}.include? char}
		end
	end

	def test_already_guessed?
		assert_equal true, @hangman_object.already_guessed?("a")
		assert_equal false, @hangman_object.already_guessed?("h")
	end

	def test_choose_word
		assert_instance_of Array, @hangman_object.choose_word("words.txt")
		assert_not_nil @hangman_object.choose_word("words.txt")
		assert_block { |char| /[[:alpha:]]/ }
		# assert_equal 5, @hangman_object.choose_word("words.txt").size # Better way to test randomness?
	end
end