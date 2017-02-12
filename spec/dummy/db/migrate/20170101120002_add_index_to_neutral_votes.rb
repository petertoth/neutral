class AddIndexToNeutralVotes < ActiveRecord::Migration
  def self.up
    add_index :neutral_votes, :voter_id
    add_index :neutral_votes, [:voteable_type, :voteable_id]
  end

  def self.down
    remove_index :neutral_votes, :voter_id
    remove_index :neutral_votes, [:voteable_type, :voteable_id]
  end
end
