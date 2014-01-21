require 'spec_helper'

describe Neutral::VotingBuilder::Structure do
  let(:random) { [true, false].sample }

  describe "#to_a" do
    describe "spans" do
      context "when not difference" do
        subject { Neutral::VotingBuilder::Structure.new(random, false).to_a }

        it { should include("positive_span") }
        it { should include("negative_span") }
        it { should_not include("difference_span") }
      end

      context "when difference" do
        subject { Neutral::VotingBuilder::Structure.new(random, true).to_a }

        it { should_not include("positive_span") }
        it { should_not include("negative_span") }
        it { should include("difference_span") }
      end
    end

    describe "remove link" do
      context "when present" do
        before do
          Neutral.configure { |config| config.can_change = true }
        end

        subject { Neutral::VotingBuilder::Structure.new(true, random).to_a }

        it { should include("remove_link") }
      end

      context "when not present" do
        context "when vote is not persisted" do
          subject { Neutral::VotingBuilder::Structure.new(false, random).to_a }

          it { should_not include("remove_link") }
        end

        context "when voter cannot change his vote" do
          before do
            Neutral.configure { |config| config.can_change = false }
          end

          after do
            Neutral.configure { |config| config.can_change = true }
          end

          subject { Neutral::VotingBuilder::Structure.new(true, random).to_a }

          it { should_not include("remove_link") }
        end
      end
    end
  end
end
