require 'spec_helper'

describe Neutral::Vote, type: :model do
  it { should belong_to :voteable }
  it { should belong_to :voter }
  it { should validate_presence_of :voteable_type }
  it { should validate_presence_of :voteable_id }
  it { should validate_presence_of :value }
  it { should validate_inclusion_of(:value).in_range(0..1) }
  
  let!(:vote) { FactoryGirl.create(:vote) }

  describe "before_update" do
    it "avoids duplication" do
      expect { vote.update_attributes(value: vote.value) }.to raise_error
    end
  end
  
  describe "after_create" do
    context "when vote's voting does not exist yet" do
      it "adds vote to voting" do
        Neutral::Voting.should_receive(:init)
        FactoryGirl.create(:vote)
      end
    end

    context "when vote's voting already exists" do
      let(:another_vote) { FactoryGirl.create(:vote, voteable: vote.voteable) }

      it "adds vote to an existing voting" do
        vote.voting.should_receive(:add_to_existing)
        another_vote
      end
    end
  end
  
  describe "after_update" do
    let(:opposite) { vote.value == 1 ? :negative : :positive }

    it "edits vote within voting" do
      vote.voting.should_receive(:edit).with(opposite)
      vote.update_attributes(value: vote.value.eql?(1) ? 0 : 1)
    end
  end
  
  describe "after_destroy" do
    it "removes vote from voting" do
      vote.voting.should_receive(:remove).with(vote.nature)
      vote.destroy
    end
  end
end
