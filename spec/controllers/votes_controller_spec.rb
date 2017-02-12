require 'spec_helper'

describe Neutral::VotesController, type: :controller do
  routes { Neutral::Engine.routes }

  include VotesControllerHelpers
  include VotesControllerBaseClass

  let!(:voteable) { FactoryGirl.create(:post) }
  let!(:voter) { FactoryGirl.create(:user) }
  let!(:vote) { FactoryGirl.create(:vote) }

  describe "POST #create" do
    context "when valid" do
      context "when login required" do
        before do
          controller.stub(:current_user).and_return(voter)
        end

        it "creates a new vote" do
          initial_count = Neutral::Vote.count
          create(voteable)
          expect(Neutral::Vote.count).to eq(initial_count + 1)
        end

        it "assigns a newly created vote as @vote" do
          create(voteable)
          assigns(:vote).should be_a(Neutral::Vote)
          assigns(:vote).should be_persisted
        end

        it "renders create template" do
          expect(create(voteable)).to render_template(:create)
        end
      end

      context "when login not required " do
        before do
          Neutral.configure { |config| config.require_login = false }
        end

        after do
          Neutral.configure { |config| config.require_login = true }
        end

        it "creates a new vote" do
          expect { create(voteable) }.to change(Neutral::Vote, :count).by(1)
        end

        it "assigns a newly created vote as @vote without a voter" do
          create(voteable)
          assigns(:vote).should be_a(Neutral::Vote)
          assigns(:vote).voter.should be_nil
          assigns(:vote).should be_persisted
        end

        it "renders create template" do
          expect(create(voteable)).to render_template(:create)
        end
      end
    end

    context "when invalid" do
      context "when login required" do
        subject { -> { create(voteable) } }

        it "does not create a vote" do
          initial_count = Neutral::Vote.count
          subject.call
          expect(Neutral::Vote.count).to eq(initial_count)
        end

        it { expect(subject.call).to render_template('errors/require_login') }
      end
    end
  end

  describe "PATCH #update" do
    context "when valid" do
      before do
        controller.stub(:current_user).and_return(vote.voter)
      end

      it "updates given vote" do
        update(vote)
        vote.value.should_not == vote.reload.value
      end

      it "assigns the vote as @vote and persists" do
        update(vote)
        assigns(:vote).should eq(vote.reload)
        assigns(:vote).should be_persisted
      end

      it "renders update template" do
        expect(update(vote)).to render_template(:update)
      end
    end

    context "when invalid" do
      it_should_behave_like "unable to change", :update

      context "when duplicated" do
        before do
          controller.stub(:current_user).and_return(vote.voter)
        end

        it "assigns the vote as @vote" do
          update vote, duplicate=true
          assigns(:vote).should eq(vote)
        end

        it "renders duplicate template" do
          expect(update(vote, duplicate=true)).to render_template('errors/duplicate')
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "when valid" do
      before do
        controller.stub(:current_user).and_return(vote.voter)
      end

      it "destroys the vote" do
        expect { destroy(vote) }.to change(Neutral::Vote, :count).by(-1)
      end

      it "assigns the vote as @vote and does not persist" do
        destroy(vote)
        assigns(:vote).should eq(vote)
        assigns(:vote).should_not be_persisted
      end

      it "renders destroy template" do
        expect(destroy(vote)).to render_template(:destroy)
      end
    end

    context "when invalid" do
      it_should_behave_like "unable to change", :destroy
    end
  end
end
