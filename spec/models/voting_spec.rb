require 'spec_helper'

describe Neutral::Voting do
  it { should belong_to(:votingable) }
  
  let(:voting) { Neutral::Voting.create }
  let(:nature) { [:positive, :negative].sample }

  describe "#difference" do
    let(:positive) { rand(100) }
    let(:negative) { rand(100) }

    subject { Neutral::Voting.new(positive: positive, negative: negative).difference }
    it { should == positive - negative }
  end

  describe "#self.init" do
    let(:vote) { FactoryGirl.build(:vote) }

    subject { Neutral::Voting.init(vote) }

    it { should be_a(Neutral::Voting) }
    it { should be_persisted }
    its(:votingable_type) { should == vote.voteable_type } 
    its(:votingable_id) { should == vote.voteable_id }
    it { subject.send(vote.nature).should == 1 }
  end

  describe "#add_to_existing" do
    it "adds vote to an existing voting" do
      voting.should_receive(:increment!).with(nature)
      voting.add_to_existing(nature)
    end
  end

  describe "#edit" do
    it "edits vote withing voting" do
      voting.should_receive(:increment).with(nature)
      voting.should_receive(:decrement).with(nature==:positive ? :negative : :positive)
      voting.should_receive(:save)
      voting.edit(nature)
    end
  end

  describe "#remove" do
    it "removes vote from voting" do
      voting.should_receive(:decrement!).with(nature)
      voting.remove(nature)
    end
  end

  describe "before_destroy" do
    let(:voting) { FactoryGirl.create(:vote).voting }

    it "deletes voting's votes" do
      voting.votes.should_receive(:delete_all)
      voting.destroy
    end
  end 
end
