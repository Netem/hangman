# hangman_spec2.rb

require_relative "spec_helper.rb"

# shared examples

shared_examples_for "when_initialized" do |type, initial_size, initial_content, right_guesses, expected_content_for_right, expected_size_for_right|
  it "is #{type}" do
    method.should be_an_instance_of type
  end

  context "when no guesses" do
  	it "returns size #{initial_size}" do
  		method.size.should eql initial_size
    end
    it "returns #{initial_content}" do
      method.should eql initial_content
    end
  end

  context "when #{right_guesses}.size guesses" do
    it "returns #{expected_content_for_right}" do

  end
end


# the things being tested
describe Hangman do
  context "#get_right_guesses" do
    it_behaves_like "when_initialized", Array, 4, %w{- - - -}, %w{r u} do
      let(:model, :method) {Hangman.new("spec\\test_words.txt"), get_right_guesses}
    end
  end
end