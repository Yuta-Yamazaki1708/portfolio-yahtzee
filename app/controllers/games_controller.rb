class GamesController < ApplicationController
  before_action :check_execution_count, only: [:roll_dices]

  INIT_DICE_NUM = 5

  def new_game
    @game = Game.new
    @game.save
    redirect_to game_path(@game)
  end

  def game
    @game = Game.find(params[:id])
    @table_dices = ["dice", "dice", "dice", "dice", "dice"]
    @keep_dices = []
  end

  def roll_dices
    @game = Game.find(params[:id])
    @table_dices = params[:table_dices]
    dice_num = @table_dices.size
    @table_dices = @game.roll_dices(dice_num)
    @keep_dices = params[:keep_dices] || []
    render "select_dice", formats: :turbo_stream
  end

  def move_to_keep
    @game = Game.find(params[:id])
    @table_dices = params[:from_dices]
    @keep_dices = params[:to_dices] || []
    index = params[:index].to_i
    @game.move(@table_dices, @keep_dices, index)
    render "select_dice", formats: :turbo_stream
  end

  def move_to_table
    @game = Game.find(params[:id])
    @keep_dices = params[:from_dices]
    @table_dices = params[:to_dices] || []
    index = params[:index].to_i
    @game.move(@keep_dices, @table_dices, index)
    render "select_dice", formats: :turbo_stream
  end

  private

  def check_execution_count
    @game = Game.find(params[:id])
    @table_dices = params[:table_dices]
    @keep_dices = params[:keep_dices] || []
    if session[:execution_count].to_i < 3
      session[:execution_count] ||= 0
      session[:execution_count] += 1
    else
      flash.now.alert = "サイコロを振れるのは3回までです。"
      render "select_dice", formats: :turbo_stream
    end
  end
end
