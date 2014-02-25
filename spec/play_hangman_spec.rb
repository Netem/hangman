# integration_spec.rb

require_relative "spec_helper.rb"

describe PlayHangman do

  before :each do
    @test = PlayHangman.new
    @test.play.secret_word = %w{r u b y}
    @test.stub(:print_info).and_return("")
  end

  shared_examples "a Hangman game session" do |input|
    it "runs through the game" do
      p input
      input.each do |letter|
        PlayHangman.stub(:get_input => letter)
        PlayHangman.playing_the_game(subject)

      end
    end
  end

  context "when winning" do
    subject {@test}
    it_behaves_like "a Hangman game session", %w{r u b y}
  end

  context "when losing" do
    subject {@test}
    it_behaves_like "a Hangman game session", %w{q a z w s x e d c f v}
  end

  context "when given invalid input" do
    subject {@test}
    it_behaves_like "a Hangman game session", %w{r r ff 6 -}
  end
end