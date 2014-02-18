# game_session.rb
require 'rubygems'
require 'pry'
require_relative "play_hangman.rb"

class GameSession
  def self.run
    session = GameSession.new
    session.play!
    session.shutdown
  end

  def play!
    begin
      PlayHangman.run
    end while play_again?
  end

  def play_again?
    print "Play again? (y/n): "
    answer = gets.to_s.downcase.chomp
    %w(y yes y! yes!).include? answer
  end

  def shutdown
    puts "Bye! Shutting down."
  end
end

GameSession.run