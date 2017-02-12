class CreateNeutralVotings < ActiveRecord::Migration
  def change
    create_table :neutral_votings do |t|
      t.string :votingable_type
      t.integer :votingable_id
      t.integer :positive, default: 0
      t.integer :negative, default: 0

      t.timestamps
    end
  end
end
