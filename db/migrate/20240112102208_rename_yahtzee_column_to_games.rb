class RenameYahtzeeColumnToGames < ActiveRecord::Migration[7.0]
  def change
    rename_column :games, :yahtzee, :yacht
  end
end
