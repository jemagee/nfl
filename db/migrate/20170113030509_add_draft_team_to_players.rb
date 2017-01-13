class AddDraftTeamToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :draft_team, :integer
    add_foreign_key :players, :teams, column: :draft_team
  end
end
