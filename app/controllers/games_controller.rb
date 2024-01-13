class GamesController < ApplicationController
  INIT_DICE_NUM = 5

  def new_game
    @game = Game.new
    @game.save
    redirect_to game_path(@game)
  end

  def game
    @game = Game.find(params[:id])
    @table_dices = [1, 1, 1, 1, 1]
    @keep_dices = []
  end

  def roll_dices
    @game = Game.find(params[:id])
    @table_dices = params[:table_dices]
    dice_num = @table_dices.size
    @table_dices = @game.roll_dices(dice_num)
    @keep_dices = params[:keep_dices]
    @keep_dices = [] if @keep_dices.nil?
    render "roll_dices", formats: :turbo_stream
  end

  def move_to_keep
    @game = Game.find(params[:id])
    @table_dices = params[:from_dices]
    @keep_dices = params[:to_dices]
    @keep_dices = [] if @keep_dices.nil?
    index = params[:index].to_i
    @game.move(@table_dices, @keep_dices, index)
    render "select_dice", formats: :turbo_stream
  end

  def move_to_table
    @game = Game.find(params[:id])
    @keep_dices = params[:from_dices]
    @table_dices = params[:to_dices]
    @table_dices = [] if @table_dices.nil?
    index = params[:index].to_i
    @game.move(@keep_dices, @table_dices, index)
    render "select_dice", formats: :turbo_stream
  end
end
