require 'spec_helper'

describe "#voting_for", type: :feature do
  class View < ActionView::Base.extend(Neutral::Helpers::ActionViewExtension)
    def current_voter;end
  end

  def view
    @view ||= View.new
  end

  let(:voteable) { FactoryGirl.create(:post) }

  context "when a valid object" do
    it "builds a voting" do
      Neutral::VotingBuilder::Builder.should_receive(:new).with(voteable, hash_including(:voter)).and_call_original
      Neutral::VotingBuilder::Builder.any_instance.should_receive(:build)
      view.voting_for voteable
    end
  end

  context "when an invalid object" do
    it "raises InvalidVoteableObject error" do
      expect { voting_for "not a voteable object" }.to raise_error
    end
  end

  context "with difference" do
    it "builds a voting with difference" do
      Neutral::VotingBuilder::Builder.should_receive(:new).with(voteable, hash_including(:voter, difference: true)).and_call_original
      Neutral::VotingBuilder::Builder.any_instance.should_receive(:build)
      view.voting_for voteable, difference: true
    end
  end

  context "with specific icon set" do
    let(:icons) { :operations }

    it "builds a voting with specific icon set" do
      Neutral::VotingBuilder::Builder.should_receive(:new).with(voteable, hash_including(:voter, icons: icons)).and_call_original
      Neutral::VotingBuilder::Builder.any_instance.should_receive(:build)
      view.voting_for voteable, icons: icons
    end
  end
end
