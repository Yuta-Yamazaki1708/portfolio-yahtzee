class GamesController < ApplicationController
  before_action :init_sessions, only: [:game]
  before_action :check_reload, only: [:game]
  before_action :check_roll_count, only: [:roll_dices]
  before_action :check_turn_count, only: [:select_category]
  before_action :check_player_turn, only: [:select_category]

  DICE_NUM = 5
  MAX_ROLL_DICES = 3
  TURN_NUM = Game::CATEGORIES.size - 2

  def select_players_num
    render "select_players_num", formats: :turbo_stream
  end

  def new_game
    if params[:player_num].blank?
      flash.now.alert = "プレイ人数を選択してください。"
      render "select_players_num", formats: :turbo_stream
    else
      session[:player_num] = params[:player_num].to_i
      session[:player_num].times do |num|
        session[:"game#{num}"] = current_user.games.new
        session[:"game#{num}"].save
      end
      redirect_to game_path
    end
  end

  def game
    unless session[:game0]
      session[:game0] = Game.new
      session[:game0].save
    end
    @categories_and_results = []
    session[:player_num].times do |num|
      @categories_and_results << Game.find(session[:"game#{num}"]["id"]).display_results
    end
    @table_dices = session[:table_dices]
    @keep_dices = session[:keep_dices]
    @calculated_scores = session[:calculated_scores]
  end

  def roll_dices
    dice_num = session[:table_dices].size
    session[:table_dices] = Game.roll_dices(dice_num)
    session[:calculated_scores] = Game.calculate_scores(session[:table_dices] + session[:keep_dices])
    @categories_and_results = []
    session[:player_num].times do |num|
      @categories_and_results << Game.find(session[:"game#{num}"]["id"]).display_results
    end
    @table_dices = session[:table_dices]
    @keep_dices = session[:keep_dices]
    @calculated_scores = session[:calculated_scores]

    render "roll_dices", formats: :turbo_stream
  end

  def move_to_keep
    index = params[:index].to_i
    Game.move(session[:table_dices], session[:keep_dices], index)
    @table_dices = session[:table_dices]
    @keep_dices = session[:keep_dices]
  end

  def move_to_table
    index = params[:index].to_i
    Game.move(session[:keep_dices], session[:table_dices], index)
    @keep_dices = session[:keep_dices]
    @table_dices = session[:table_dices]
  end

  def select_category
    @games = []
    session[:player_num].times do |num|
      @games << Game.find(session[:"game#{num}"]["id"])
    end
    game = @games[params[:game].to_i]
    if game.update(params[:category] => session[:calculated_scores][params[:category]]) &&
      game.update("bonus" => bonus(game)) &&
      game.update("sum" => sum(game))
    else
      flash.now.alert = "エラーが発生しました。"
      session[:turn_count] -= 1
    end

    session[:table_dices] = Array.new(DICE_NUM) { 0 }
    session[:keep_dices] = []
    session[:calculated_scores] = {}

    @table_dices = session[:table_dices]
    @keep_dices = session[:keep_dices]
    @categories_and_results = []
    session[:player_num].times do |num|
      @categories_and_results << Game.find(session[:"game#{num}"]["id"]).display_results
    end
    @calculated_scores = session[:calculated_scores]

    if session[:turn_count].to_i < TURN_NUM * session[:player_num]
      render "select_category", formats: :turbo_stream
    else
      session[:turn_count] = nil
      render "game_over", formats: :turbo_stream
    end
  end

  # javascriptで使用する変数をjsonAPIで出力する.
  def get_roll_count
    render json: {
      roll_count: session[:roll_count],
      max_roll_dices: MAX_ROLL_DICES,
    }
  end

  private

  def init_sessions
    session[:roll_count] = nil
    session[:table_dices] = Array.new(DICE_NUM) { 0 }
    session[:keep_dices] = []
    session[:calculated_scores] = {}
    session[:player_turn] = 0
  end

  # サイコロを振った回数を記録する.
  def check_roll_count
    if session[:roll_count].to_i < MAX_ROLL_DICES
      session[:roll_count] ||= 0
      session[:roll_count] += 1
    else
      session[:roll_count] += 1
      flash.now.alert = "サイコロを振れるのは3回までです。"
      @categories_and_results = []
      session[:player_num].times do |num|
        @categories_and_results << Game.find(session[:"game#{num}"]["id"]).display_results
      end
      @calculated_scores = Game.calculate_scores(session[:table_dices] + session[:keep_dices])
      @table_dices = session[:table_dices]
      @keep_dices = session[:keep_dices]

      render "roll_dices", formats: :turbo_stream
    end
  end

  # ターン数を記録する.
  def check_turn_count
    session[:turn_count] ||= 0
    session[:turn_count] += 1
    session[:roll_count] = nil
  end

  # プレイヤーのターンを記録する.
  def check_player_turn
    session[:player_turn] = session[:turn_count] % session[:player_num]
  end

  # ゲームの途中でリロードされた場合、ゲームを中止してホームへリダイレクト.
  def check_reload
    unless session[:turn_count].nil?
      session[:turn_count] = nil
      game = Game.find(session[:game0]["id"])
      game.destroy
      flash.notice = "リロードされたためゲームを中止しました。"

      redirect_to root_path
    end
  end

  def bonus(game)
    categories_from_one_to_six = ["one", "two", "three", "four", "five", "six"]
    from_one_to_six = categories_from_one_to_six.index_with { |category| game.public_send(category).to_i }
    if from_one_to_six.values.inject(:+) >= 63
      35
    else
      0
    end
  end

  def sum(game)
    categories_remove_sum = Game::CATEGORIES.reject { |category| category == "sum" }
    categories_remove_sum.index_with { |category| game.public_send(category).to_i }.values.inject(:+)
  end
end
