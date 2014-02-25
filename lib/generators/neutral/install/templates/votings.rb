class CreateNeutralVotings < ActiveRecord::Migration
  def change
    create_table :neutral_votings do |t|
      t.belongs_to :votingable, polymorphic: true
      t.integer :positive, default: 0
      t.integer :negative, default: 0

      t.timestamps
    end
  end
end
