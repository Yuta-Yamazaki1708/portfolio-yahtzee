class GamesController < ApplicationController
  before_action :check_reload, only: [:game]
  before_action :check_roll_count, only: [:roll_dices]
  before_action :check_turn_count, only: [:select_category]

  DICE_NUM = 5
  TIMES_OF_ROLL_DICES = 3
  TURN_NUM = Game::CATEGORIES.size - 2

  def new_game
    @game = Game.new
    @game.save
    redirect_to game_path(@game)
  end

  def game
    session[:roll_count] = nil
    @game = Game.find(params[:id])
    @categories_and_results = @game.display_results
    @table_dices = Array.new(DICE_NUM) { "Dice" }
    @keep_dices = []
    @calculated_scores = {}
  end

  def roll_dices
    @game = Game.find(params[:id])
    @categories_and_results = @game.display_results
    dice_num = param_to_integer(params[:table_dices]).size
    @table_dices = Game.roll_dices(dice_num)
    @keep_dices = param_to_integer(params[:keep_dices]) || []
    @calculated_scores = Game.calculate_scores(@table_dices + @keep_dices)
    render "roll_dices", formats: :turbo_stream
  end

  def move_to_keep
    @game = Game.find(params[:id])
    @table_dices = param_to_integer(params[:from_dices])
    @keep_dices = param_to_integer(params[:to_dices]) || []
    index = params[:index].to_i
    Game.move(@table_dices, @keep_dices, index)
  end

  def move_to_table
    @game = Game.find(params[:id])
    @keep_dices = param_to_integer(params[:from_dices])
    @table_dices = param_to_integer(params[:to_dices]) || []
    index = params[:index].to_i
    Game.move(@keep_dices, @table_dices, index)
  end

  def select_category
    @game = Game.find(params[:id])
    @game.update(params[:category] => params[:calculated_score].to_i)
    @table_dices = Array.new(DICE_NUM) { "Dice" }
    @keep_dices = []
    @categories_and_results = @game.display_results
    @calculated_scores = {}
    if session[:turn_count].to_i < TURN_NUM
      render "select_category", formats: :turbo_stream
    else
      session[:turn_count] = nil
      session[:roll_count] = nil
      render "game_over", formats: :turbo_stream
    end
  end

  private

  def check_roll_count
    @game = Game.find(params[:id])
    @categories_and_results = @game.display_results
    @table_dices = param_to_integer(params[:table_dices])
    @keep_dices = param_to_integer(params[:keep_dices]) || []
    @calculated_scores = Game.calculate_scores(@table_dices + @keep_dices)
    if session[:roll_count].to_i < TIMES_OF_ROLL_DICES
      session[:roll_count] ||= 0
      session[:roll_count] += 1
    else
      flash.now.alert = "サイコロを振れるのは3回までです。"
      render "roll_dices", formats: :turbo_stream
    end
  end

  def check_turn_count
    session[:roll_count] = nil
    session[:turn_count] ||= 0
    session[:turn_count] += 1
  end

  def check_reload
    unless session[:turn_count].nil?
      session[:turn_count] = nil
      session[:roll_count] = nil
      game = Game.find(params[:id])
      game.destroy
      flash.notice = "リロードされたためゲームを中止しました。"
      redirect_to root_path
    end
  end

  def param_to_integer(array_of_param)
    if array_of_param.nil?
      return
    end
    array_of_param.map(&:to_i)
  end
end
