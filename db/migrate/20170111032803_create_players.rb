class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :oldid
      t.integer :nflcomid
      t.integer :height
      t.date :birth_date
      t.string :college
      t.integer :draft_year
      t.integer :draft_round
      t.integer :round_pick
      t.integer :overall_pick

      t.timestamps
    end
  end
end
