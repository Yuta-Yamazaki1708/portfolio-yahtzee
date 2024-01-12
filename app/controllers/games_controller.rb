class GamesController < ApplicationController
  DICE_NUM = 5

  def new
    @game = Game.new(DICE_NUM)
  end
end
