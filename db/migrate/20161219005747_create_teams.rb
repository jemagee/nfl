class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :abbr
      t.string :city
      t.string :nickname
      t.belongs_to :division, foreign_key: true

      t.timestamps
    end
  end
end
