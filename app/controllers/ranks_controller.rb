class RanksController < ApplicationController
  def all
    @ranks = Game.eager_load(user: { icon_attachment: :blob }).order(:sum => 'desc').page(params[:page])
    @current_page = @ranks.current_page
  end

  def weekly
    @weekly_ranks = Game.eager_load(user: { icon_attachment: :blob }).
      where(updated_at: Time.current.all_week).order(:sum => 'desc').page(params[:page])
    @first_day = Time.current.all_week.first
    @last_day = Time.current.all_week.last
    @current_page = @weekly_ranks.current_page
  end
end
