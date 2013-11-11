class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @facebook_user = FbGraph::User.me(current_user.facebook_token).fetch
    UserPhotosWorker.perform_async(current_user.id)
  end

  def fetch_photo
  end

  def ranking
    UserPhotosWorker.perform_async(current_user.id)
    @scores = current_user.scores.includes(:friend).order(score: :desc)
    @scores = @scores.where(gender: params[:gender]) if params[:gender]
  end
end
