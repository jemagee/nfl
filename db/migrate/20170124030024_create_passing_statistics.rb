class CreatePassingStatistics < ActiveRecord::Migration[5.0]
  def change
    create_table :passing_statistics do |t|
      t.belongs_to :player, foreign_key: true
      t.belongs_to :participant, foreign_key: true
      t.integer :att
      t.integer :comp
      t.integer :yds
      t.integer :tds
      t.integer :ints
      t.integer :twopta
      t.integer :twoptm

      t.timestamps
    end
  end
end
