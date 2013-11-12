class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
  end

  def show
    @score = current_user.scores.where(friend_id: @user.id).first
    @photo_datas = PhotoData.where(user_id: @score.friend_id).includes(:photo)
  end

  def fetch_photo
  end

  def ranking
  	@user = current_user
  	@facebook_user = FbGraph::User.me(current_user.facebook_token).fetch
    UserPhotosWorker.perform_async(current_user.id)
    @scores = current_user.scores.includes(:friend).order(score: :desc)
    @scores = @scores.joins(:user).where(users: { gender: params[:gender] }) if params[:gender]

    #binding.pry
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

