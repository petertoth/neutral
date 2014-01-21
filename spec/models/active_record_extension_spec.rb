require 'spec_helper'

extended = ActiveRecord::Base.extend(Neutral::Model::ActiveRecordExtension)

class Item < extended
  neutral
end

class Client < extended
  neutral_voter
end

describe Item, type: :model do
  it { should be_a(Neutral::Model::ActiveRecordExtension::Voteable) }

  before do
    @migration = ActiveRecord::Migration.new
    @migration.verbose = false
    @migration.create_table(:items)
  end

  after do
    @migration.drop_table(:items)
  end

  describe "#neutral" do
    it { should have_many(:votes) }
    it { should have_many(:voters) }
    it { should have_one(:voting) }
  end
end

describe Client, type: :model do
  it { should be_a(Neutral::Model::ActiveRecordExtension::Voter) }

  before do
    @migration = ActiveRecord::Migration.new
    @migration.verbose = false
    @migration.create_table(:clients)
  end

  after do
    @migration.drop_table(:clients)
  end

  describe "#neutral_voter" do
    it { should have_many(:votes_given) }
  end
end
