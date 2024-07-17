module GamesHelper
  def move_btn_params(index)
    {
      index: index,
    }
  end

  def select_category_params(game, category)
    {
      game: game,
      category: category,
    }
  end

  def results_locals(categories_and_results, calculated_scores)
    {
      categories_and_results: categories_and_results,
      calculated_scores: calculated_scores,
    }
  end

  def field_locals(table_dices, keep_dices)
    {
      table_dices: table_dices,
      keep_dices: keep_dices,
    }
  end
end
