class SetUpDefaultsForPlayerDraftInformation < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :players, :draft_year, 0
  	change_column_default :players, :draft_round, 0
  	change_column_default :players, :round_pick, 0
  	change_column_default :players, :overall_pick, 0
  end
end
