class CreateNeutralVotes < ActiveRecord::Migration
  def change
    create_table :neutral_votes do |t|
      t.string :voteable_type
      t.integer :voteable_id
      t.integer :voter_id
      t.integer :value

      t.timestamps
    end
  end
end
