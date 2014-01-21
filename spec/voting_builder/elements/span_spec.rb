require 'spec_helper'

include Neutral::VotingBuilder::Elements
    
describe Span, type: :feature do
  [Span::Positive, Span::Negative].each do |span|
    describe span do
      describe "#to_s" do
        let(:total) { rand(100) + 1 }

        subject { Capybara.string span.new(total).to_s }

        it { should have_selector("span##{span.to_s.demodulize.downcase}") }

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
    describe "#to_s" do
      let(:positive) { rand(100) + 1 }
      let(:negative) { -(rand(100) + 1) }

      it "has absolute value of total" do
        Capybara.string(Span::Difference.new(negative).to_s).find("span").text.to_i.should > 0
      end                       

      it "has 'positive' class when positive value of total is passed" do
        Capybara.string(Span::Difference.new(positive).to_s).find("span")[:class].should == "positive"    
      end

      it "has 'negative' class when negative value of total is passed" do
        Capybara.string(Span::Difference.new(negative).to_s).find("span")[:class].should == "negative"    
      end
    end
  end
end
