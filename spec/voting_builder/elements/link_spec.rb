require 'spec_helper'

include Neutral::VotingBuilder::Elements

describe Link, type: :feature do
  let(:vote) { FactoryGirl.create(:vote) }

  [Link::Positive, Link::Negative, Link::Remove].each do |link|
    describe link do
      let(:klass) { link.to_s.demodulize.downcase }
      let(:router) { Neutral::VotingBuilder::Router.new(vote).send(klass) }
      let(:icon) { "fa-#{klass}" }

      subject { Capybara.string link.new(router, icon).to_s }

      it { should have_selector("a.#{klass}") }

      it "has corresponding path" do
        subject.find("a.#{klass}")[:href].should include(router[:path])
      end

      it "has corresponding HTTP method" do
        subject.find("a.#{klass}")["data-method"].should == router[:method]
      end

      it "has valid FontAwesome icon class" do
        subject.find("i")[:class].should == "fa #{icon}"
      end
    end
  end
end
