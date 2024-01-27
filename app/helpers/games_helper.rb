module GamesHelper
  def move_btn_params(index)
    {
      index: index,
    }
  end

  def select_category_params(category)
    {
      category: category,
    }
  end

  def results_locals(game, categories_and_results, calculated_scores)
    {
      game: game,
      categories_and_results: categories_and_results,
      calculated_scores: calculated_scores,
    }
  end

  def field_locals(game, table_dices, keep_dices)
    {
      game: game,
      table_dices: table_dices,
      keep_dices: keep_dices,
    }
  end
end
