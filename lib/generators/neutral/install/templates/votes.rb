class CreateNeutralVotes < ActiveRecord::Migration
  def change
    create_table :neutral_votes do |t|
      t.belongs_to :voter
      t.belongs_to :voteable, polymorphic: true
      t.integer :value, null: false

      t.timestamps
    end
  end
end
