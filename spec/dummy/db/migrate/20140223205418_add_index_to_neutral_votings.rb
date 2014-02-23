class AddIndexToNeutralVotings < ActiveRecord::Migration
  def self.up
    add_index :neutral_votings, [:votingable_type, :votingable_id]
  end

  def self.down
    remove_index :neutral_votings, [:votingable_type, :votingable_id]
  end
end
