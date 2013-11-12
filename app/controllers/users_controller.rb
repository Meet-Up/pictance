class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
  end

  def show
    @score = current_user.scores.where(friend_id: @user.id).first
    photo_datas = PhotoData.where(user_id: current_user.id).includes(:photo)
    @photo_datas = photo_datas.joins(:data).where(photo_data: { user_id: @user.id})
  end

  def loading
    @user = current_user
    @facebook_user = FbGraph::User.me(current_user.facebook_token).fetch
  end

  def fetch_photo
    @photo = PhotoData.where(user: current_user).last.photo
    @progress = Photo.where(user_id: current_user).count
    render json: { photo: @photo, progress: @progress }
  end

  def ranking
    @user = current_user
    @gender = params[:gender].nil? ? -1 : params[:gender].to_i
  	@facebook_user = FbGraph::User.me(current_user.facebook_token).fetch
    UserPhotosWorker.perform_async(current_user.id)
    @scores = current_user.scores.includes(:friend).order(score: :desc)
    @scores = @scores.joins(:friend).where(users: { gender: params[:gender].to_i }) if params[:gender]
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end

