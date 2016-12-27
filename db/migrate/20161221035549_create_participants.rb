class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.belongs_to :game, foreign_key: true
      t.belongs_to :team, foreign_key: true
      t.string :homeaway
      t.string :winlosstie
      t.integer :q1
      t.integer :q2
      t.integer :q3
      t.integer :q4
      t.integer :ot

      t.timestamps
    end
  end
end
