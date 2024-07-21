class PostsController < ApplicationController
  def new
    @posts = []
    @games = []
    session[:player_num].times do |num|
      @posts << Post.new
      @games << Game.find(session[:"game#{num}"]["id"])
    end
  end

  def create
    @posts = []
    @games = []
    session[:player_num].times do |num|
      @posts << Post.new(post_params)
      @games << Game.find(session[:"game#{num}"]["id"])
    end
    if @posts.any? { |post| post.save }
      session[:post_num] = params[:post_num]
      flash.now.notice = "結果を投稿しました。"
      render "post", formats: :turbo_stream
    else
      flash.now.alert = "結果の投稿に失敗しました。"
      render "post", formats: :turbo_stream
    end
  end

  private

  def post_params
    params.require(:post).permit(:point, :comment, :user_id, :game_id)
  end
end
