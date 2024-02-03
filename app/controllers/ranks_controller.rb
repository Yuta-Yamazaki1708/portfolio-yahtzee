class RanksController < ApplicationController
  def index
    @ranks = Game.eager_load(:user).order(:sum => 'desc').page(params[:page])
    @current_page = @ranks.current_page
  end
end
