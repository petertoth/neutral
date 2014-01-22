require 'spec_helper'

include Neutral::VotingBuilder::Elements
    
describe Span, type: :feature do
  [Span::Positive, Span::Negative].each do |span|
    describe span do
      describe "#to_s" do
        let(:total) { rand(100) + 1 }
        let(:klass) { span.to_s.demodulize.downcase }

        subject { Capybara.string span.new(total).to_s }

        it { should have_selector("span.#{klass}") }

        it "has value of given total" do
          subject.find("span").text.should == total.to_s
        end

        it "nullifies total of zero" do
          Capybara.string(span.new(0).to_s).text.should == ""
        end
      end
    end
  end

  describe Span::Difference do
    def difference_element(total)
      Capybara.string(Span::Difference.new(total).to_s).find("span")
    end

    describe "#to_s" do
      let(:positive) { rand(100) + 1 }
      let(:negative) { -(rand(100) + 1) }

      it "has absolute value of total" do
        difference_element(negative).text.to_i.should > 0
      end                       

      it "has 'positive' class when positive value of total is passed" do
        difference_element(positive)[:class].should include("positive")
      end

      it "has 'negative' class when negative value of total is passed" do
        difference_element(negative)[:class].should include("negative") 
      end
    end
  end
end
