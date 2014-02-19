#test.rb

require_relative "hangman.rb"

a = Hangman.new

puts "a is valid? #{a.is_valid?("a")}"
puts "aa is valid? #{a.is_valid?("aa")}"
puts "? is valid? #{a.is_valid?("?")}"
p a.is_valid?("?")

# WHY nil INSTEAD OF false ?!