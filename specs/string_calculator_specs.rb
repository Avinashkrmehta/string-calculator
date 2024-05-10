require_relative '../lib/string_calculator'
require_relative '../lib/negatives_not_allowed'
describe StringCalculator do
  let(:calculator) { StringCalculator.new }

  context "when adding numbers" do
    it "returns 0 for an empty string" do
      expect(calculator.add("")).to eq(0)
    end

    it "returns the number itself if only one number is provided" do
      expect(calculator.add("1")).to eq(1)
    end

    it "returns the sum of two numbers separated by a comma" do
      expect(calculator.add("1,2")).to eq(3)
    end

    it "handles new lines between numbers" do
      expect(calculator.add("1\n2,3")).to eq(6)
    end

    it "handles custom delimiters" do
      expect(calculator.add("//;\n1;2")).to eq(3)
    end

    it "ignores numbers greater than 1000" do
      expect(calculator.add("1001,2")).to eq(2)
    end

    it "raises an exception for negative numbers" do
      expect { calculator.add("-1,2,-3") }.to raise_error(NegativesNotAllowed, "Negatives Not Allowed: -1, -3")
    end

    it "returns 0 for an empty string with spaces" do
      expect(calculator.add(" ")).to eq(0)
    end

    it "returns the number itself for a single number" do
      expect(calculator.add("10")).to eq(10)
    end

    it "returns the sum of multiple numbers" do
      expect(calculator.add("10, 50, 90, 100")).to eq(250)
    end

    it "handles newlines as delimiters" do
      expect(calculator.add("10, 20\n 30")).to eq(60)
    end

    it "raises an error for negative numbers" do
      expect { calculator.add("-17,-18,10") }.to raise_error(NegativesNotAllowed) do |error|
        expect(error.message).to eq("Negatives Not Allowed: -17, -18")
      end
    end  
  end
end
