class ChangeOTtoQ5InParticipant < ActiveRecord::Migration[5.0]
  def change
  	rename_column :participants, :ot, :q5
  end
end
