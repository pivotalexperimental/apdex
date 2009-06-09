require File.expand_path("#{File.dirname(__FILE__)}/../spec_helper")

module Apdex
  describe Calculate do
    describe "#call" do
      context "when the sum of the tolerating counts is odd" do
        it "calculates the correct score" do
          Calculate.new.call(1, [2, 0.5]).should == {
            :satisfied => 1,
            :tolerating => 1,
            :frustrated => 0,
            :score => 0.75
          }
        end
      end
    end
  end
end
