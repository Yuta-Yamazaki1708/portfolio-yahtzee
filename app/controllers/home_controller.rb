class HomeController < ApplicationController
  def index
    @posts = Post.all.limit(20).order("id DESC").includes(:user, :game)
  end
end
