require 'spec_helper'

describe Neutral::VotingBuilder::Router do
  include Neutral::Engine.routes.url_helpers

  context "for a persisted vote" do
    let(:vote) { FactoryGirl.create(:vote) }

    subject { Neutral::VotingBuilder::Router.new(vote) }

    describe "#positive" do
      subject { super().positive }

      it { expect(subject[:path]).to eq(vote_path(vote, value: 1)) }
      it { expect(subject[:method]).to eq('patch') }
    end

    describe "#negative" do
      subject { super().negative }

      it { expect(subject[:path]).to eq(vote_path(vote, value: 0)) }
      it { expect(subject[:method]).to eq('patch') }
    end

    describe "#remove" do
      subject { super().remove }

      it { expect(subject[:path]).to eq(vote_path(vote)) }
    end
  end

  context "for a not persisted vote" do
    let(:vote) { FactoryGirl.build(:vote) }

    subject { Neutral::VotingBuilder::Router.new(vote) }

    describe "#positive" do
      subject { super().positive }

      it { expect(subject[:path]).to eq(votes_path(vote: vote.main_attributes.merge(value: 1))) }
      it { expect(subject[:method]).to eq('post') }
    end

    describe "#negative" do
      subject { super().negative }

      it { expect(subject[:path]).to eq(votes_path(vote: vote.main_attributes.merge(value: 0))) }
      it { expect(subject[:method]).to eq('post') }
    end

    describe "#remove" do
      subject { -> { super().remove } }

      it { should raise_error }
    end
  end
end
