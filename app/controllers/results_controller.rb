class ResultsController < ApplicationController
  def show
    @user = current_user
    @result = Game.find(params[:id]).display_results
  end
end
