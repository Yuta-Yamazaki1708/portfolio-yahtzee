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
      render "new"
    end
  end

  def destroy
    @posts = Post.all.limit(20).order("id DESC").includes(:user, :game)
    @post = Post.find(params[:id])
    @post.destroy
    flash.now.notice = "投稿を削除しました。"
    render "destroy", formats: :turbo_stream
  end

  private

  def post_params
    params.require(:post).permit(:point, :comment, :user_id, :game_id)
  end
end
