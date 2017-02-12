require 'spec_helper'

describe Neutral::Icons::Collection do
  let(:collection) { Neutral::Icons::Collection.new }
  let(:set) { Neutral::Icons::Set.new(:my_test_icons) }

  describe "#add" do
    context "when given set already exists" do
      let(:set) { Neutral::Icons::Set.new(:thumbs) }

      it "raises AlreadyDefinedIconSet error" do
        expect { collection.add(set.name, set.definitions) }.to raise_error
      end
    end

    context "when given set does not exist yet" do
      it "defines method on icons object with given set name and definitions" do
        collection.should_receive(:define!).with(set.name, set.definitions)
        collection.add(set)
      end
    end
  end

  describe "#define!" do
    before do
      collection.send(:define!, set.name, set.definitions)
    end

    subject { collection.send(set.name) }

    it { should be_a(Neutral::Icons::Collection::Definitions) }

    [:positive, :negative, :remove].each do |definition|
      it { expect(subject.send(definition)).to eq set.definitions[definition] }
    end
  end
end
