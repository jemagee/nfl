class CreateDivisions < ActiveRecord::Migration[5.0]
  def change
    create_table :divisions do |t|
      t.string :name
      t.string :conference

      t.timestamps
    end
  end
end
