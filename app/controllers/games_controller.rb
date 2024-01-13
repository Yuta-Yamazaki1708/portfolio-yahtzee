class GamesController < ApplicationController
  INIT_DICE_NUM = 5

  def new_game
    @game = Game.new
    @game.save
    redirect_to game_path(@game)
  end

  def game
    @game = Game.find(params[:id])
    @dices = Array.new(INIT_DICE_NUM) { nil }
    @keep_dices = [nil]
  end

  def roll_dices
    @game = Game.find(params[:id])
    @dices = params[:dices]
    dice_num = @dices.size
    @dices = @game.roll_dices(dice_num)
    @keep_dices = params[:keep_dices]
    render "roll_dices", formats: :turbo_stream
  end
end
