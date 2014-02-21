# shared context

shared_context "depends on guesses" do
  before :each do
    @shared_play = Hangman.new "test_words.txt"
  end

  def when_no_guess method, expected_content
    describe "when no guesses" do
      @shared_play.method.should eql expected_content
    end
  end
end