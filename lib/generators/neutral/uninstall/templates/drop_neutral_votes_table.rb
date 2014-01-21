class DropNeutralVotesTable < ActiveRecord::Migration
  def up
    drop_table :neutral_votes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
