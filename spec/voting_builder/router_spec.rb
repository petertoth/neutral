require 'spec_helper'

describe Neutral::VotingBuilder::Router do
  include Neutral::Engine.routes.url_helpers

  context "for a persisted vote" do
    let(:vote) { FactoryGirl.create(:vote) }

    subject { Neutral::VotingBuilder::Router.new(vote) }

    describe "#positive" do
      subject { super().positive }

      its([:path]) { should eq(vote_path(vote, value: 1)) }
      its([:method]) { should eq('patch') }
    end

    describe "#negative" do
      subject { super().negative }

      its([:path]) { should eq(vote_path(vote, value: 0)) }
      its([:method]) { should eq('patch') }
    end

    describe "#remove" do
      subject { super().remove }

      its([:path]) { should eq(vote_path(vote)) }
    end
  end

  context "for a not persisted vote" do
    let(:vote) { FactoryGirl.build(:vote) }

    subject { Neutral::VotingBuilder::Router.new(vote) }

    describe "#positive" do
      subject { super().positive }

      its([:path]) { should eq(votes_path(vote: vote.main_attributes.merge(value: 1))) }
      its([:method]) { should eq('post') }
    end

    describe "#negative" do
      subject { super().negative }

      its([:path]) { should eq(votes_path(vote: vote.main_attributes.merge(value: 0))) }
      its([:method]) { should eq('post') }
    end

    describe "#remove" do
      subject { -> { super().remove } }

      it { should raise_error }
    end
  end
end
