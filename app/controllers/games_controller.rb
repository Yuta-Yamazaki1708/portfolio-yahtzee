class GamesController < ApplicationController
  before_action :check_roll_count, only: [:roll_dices]

  DICE_NUM = 5
  TIMES_OF_ROLL_DICES = 3

  def new_game
    @game = Game.new
    @game.save
    redirect_to game_path(@game)
  end

  def game
    session[:execution_count] = 0
    @game = Game.find(params[:id])
    @categories_and_results = @game.display_results
    @table_dices = Array.new(DICE_NUM) { "Dice" }
    @keep_dices = []
    @calculated_scores = {}
  end

  def roll_dices
    @game = Game.find(params[:id])
    @categories_and_results = @game.display_results
    @table_dices = param_to_integer(params[:table_dices])
    dice_num = @table_dices.size
    @table_dices = @game.roll_dices(dice_num)
    @keep_dices = param_to_integer(params[:keep_dices]) || []
    @calculated_scores = @game.calculate_scores(@table_dices + @keep_dices)
    render "update_dices", formats: :turbo_stream
  end

  def move_to_keep
    @game = Game.find(params[:id])
    @categories_and_results = @game.display_results
    @table_dices = param_to_integer(params[:from_dices])
    @keep_dices = param_to_integer(params[:to_dices]) || []
    index = params[:index].to_i
    @game.move(@table_dices, @keep_dices, index)
    @calculated_scores = @game.calculate_scores(@table_dices + @keep_dices)
    render "update_dices", formats: :turbo_stream
  end

  def move_to_table
    @game = Game.find(params[:id])
    @categories_and_results = @game.display_results
    @keep_dices = param_to_integer(params[:from_dices])
    @table_dices = param_to_integer(params[:to_dices]) || []
    index = params[:index].to_i
    @game.move(@keep_dices, @table_dices, index)
    @calculated_scores = @game.calculate_scores(@table_dices + @keep_dices)
    render "update_dices", formats: :turbo_stream
  end

  def select_category
    @game = Game.find(params[:id])
    @game.update(params[:category] => params[:calculated_score].to_i)
    @table_dices = Array.new(DICE_NUM) { "Dice" }
    @keep_dices = []
    @categories_and_results = @game.display_results
    @calculated_scores = {}
    session[:execution_count] = 0
    render "update_dices", formats: :turbo_stream
  end

  private

  def check_roll_count
    @game = Game.find(params[:id])
    @categories_and_results = @game.display_results
    @table_dices = param_to_integer(params[:table_dices])
    @keep_dices = param_to_integer(params[:keep_dices]) || []
    @calculated_scores = @game.calculate_scores(@table_dices + @keep_dices)
    if session[:execution_count].to_i < TIMES_OF_ROLL_DICES
      session[:execution_count] ||= 0
      session[:execution_count] += 1
    else
      flash.now.alert = "サイコロを振れるのは3回までです。"
      render "update_dices", formats: :turbo_stream
    end
  end

  def param_to_integer(array_of_param)
    if array_of_param.nil?
      return
    end
    array_of_param.map(&:to_i)
  end
end
