module GamesHelper
  def move_btn_params(game, from_dices, to_dices, index)
    { id: game.id, from_dices: from_dices, to_dices: to_dices, index: index }
  end

  def roll_dices_params(game, table_dices, keep_dices)
    { id: game.id, table_dices: table_dices, keep_dices: keep_dices }
  end

  def select_category_params(game, category, calculated_score)
    { id: game.id, category: category, calculated_score: calculated_score }
  end
end
