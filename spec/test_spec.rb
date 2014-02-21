# test.rb

# SHARED EXAMPLES

:method_name
:expected_class
:initial_output

    context "when no guesses" do
      it "is #{expected_class}" do
        @play.method_name.should be_an_instance_of expected_class
      end
      it "contains #{initial_content}" do
        @play.method_name.should eql initial_output
      end
    end

:method_name
:correct_guesses
:expected_output

      context "when #{correct_guesses.size} correct guesses" do
      it "contains #{expected_output}" do
        @play.guesses = correct_guesses
        @play.method_name.should eql expected_output
      end
    end

:method_name
:incorrect_guesses
:expected_output

      context "when #{incorrect_guesses.size} correct guesses" do
      it "contains #{expected_output}" do
        @play.guesses = incorrect_guesses
        @play.method_name.should eql expected_output
      end
    end

method_name
:correct_guesses
:incorrect_guesses
:expected_output

      context "when #{correct_guesses.size} correct guesses, and #{incorrect_guesses.size} correct guesses" do
      it "contains #{expected_output}" do
        @play.guesses = incorrect_guesses + correct_guesses
        @play.method_name.should eql expected_output
      end
    end