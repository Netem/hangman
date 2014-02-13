# gamesession.rb

require_relative "hangmanmain.rb"

class GameSession
  def self.run
    session = GameSession.new
    session.play!
    session.shutdown
  end

  def play!
    begin
      PlayHangman.run
    end until play_again? == false
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