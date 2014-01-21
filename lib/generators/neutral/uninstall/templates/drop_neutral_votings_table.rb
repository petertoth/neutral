class DropNeutralVotingsTable < ActiveRecord::Migration
  def up
    drop_table :neutral_votings
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
