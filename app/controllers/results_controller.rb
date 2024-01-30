class ResultsController < ApplicationController
  def show
    @user = current_user
    @result = Game.find(params[:id]).display_results
  end

  def destroy
    @user = current_user
    @results = @user.games
    @result = Game.find(params[:id])
    @result.destroy
    flash.now.notice = "結果を削除しました。"
    render "destroy", formats: :turbo_stream
  end
end
