require 'spec_helper'

describe Neutral::VotingBuilder::Builder, type: :feature do
  describe "#build" do
    let(:voteable) { FactoryGirl.create(:post) }
    let(:vote) { FactoryGirl.create(:vote) }

    context "basic built" do
      subject { Neutral::VotingBuilder::Builder.new(voteable, {}).build }

      it { should have_selector "div.neutral" }
      it { should have_selector "span.positive" }
      it { should have_selector "a.positive" }
      it { should have_selector "a.negative" }
      it { should have_selector "span.negative" }
    end

    context "with difference" do
      subject { Neutral::VotingBuilder::Builder.new(voteable, difference: true).build }

      it { should have_selector "span.difference" }
    end

    describe "remove link" do
      context "when present" do
        before do
          Neutral.configure { |config| config.can_change = true }
        end

        subject { Neutral::VotingBuilder::Builder.new(vote.voteable, voter: vote.voter).build }

        it { should have_selector "a.remove" }
      end

      context "when not present" do
        context "when current voter has not voted yet or is not an owner of the vote" do
          let(:voteable) { vote.voteable }
          let(:voter) { vote.voter }

          before do
            vote.destroy
          end

          subject { Neutral::VotingBuilder::Builder.new(voteable, voter: voter).build }
          it { should_not have_selector "a.remove" }
        end

        context "when current voter has voted but cannot change the vote" do
          before do
            Neutral.configure { |config| config.can_change = false }
          end

          after do
            Neutral.configure { |config| config.can_change = true }
          end

          subject { Neutral::VotingBuilder::Builder.new(vote.voteable, voter: vote.voter).build }
          
          it { should_not have_selector("a.remove") }
        end
      end
    end
  end
end
