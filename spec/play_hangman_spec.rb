# integration_spec.rb

require_relative "spec_helper.rb"

describe PlayHangman do

  context "winning scenario" do
    it "returns true" do
      @test = PlayHangman.new
      @test.play.secret_word = %w{r u b y}
      PlayHangman.stub(:get_input => "r")
      PlayHangman.get_input
      PlayHangman.playing_the_game(@test)

      PlayHangman.stub(:get_input => "u")
      PlayHangman.get_input
      PlayHangman.playing_the_game(@test)

      PlayHangman.stub(:get_input => "b")
      PlayHangman.get_input
      PlayHangman.playing_the_game(@test)

      PlayHangman.stub(:get_input => "y")
      PlayHangman.get_input
      PlayHangman.playing_the_game(@test).should be_true
    end
  end
end