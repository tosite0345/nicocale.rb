# frozen_string_literal: true

class UserEmotionsController < ApplicationController
  before_action :set_user_emotion, only: [:show, :edit, :update, :destroy]
  before_action :set_team_user# ,    only: [:create]

  # GET /user_emotions
  # GET /user_emotions.json
  def index
    @user_emotions = UserEmotion.all
  end

  # GET /user_emotions/1
  # GET /user_emotions/1.json
  def show
  end

  # GET /user_emotions/new
  def new
    @user_emotion = UserEmotion.new
  end

  # GET /user_emotions/1/edit
  def edit
  end

  # POST /user_emotions
  # POST /user_emotions.json
  def create
    @user_emotion = UserEmotion.new(user_emotion_params)
    respond_to do |format|
      if @user_emotion.save
        format.html { redirect_back(fallback_location: root_path, notice: "Team was successfully updated.") }
        # format.html { redirect_to @user_emotion, notice: "User emotion was successfully created." }
        format.json { render :show, status: :created, location: @user_emotion }
      else
        format.html { redirect_back(fallback_location: root_path, notice: "Team was successfully updated.") }
        # format.html { render :new }
        format.json { render json: @user_emotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_emotions/1
  # PATCH/PUT /user_emotions/1.json
  def update
    respond_to do |format|
      if @user_emotion.update(user_emotion_params)
        format.html { redirect_to @user_emotion, notice: "User emotion was successfully updated." }
        format.json { render :show, status: :ok, location: @user_emotion }
      else
        format.html { render :edit }
        format.json { render json: @user_emotion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_emotions/1
  # DELETE /user_emotions/1.json
  def destroy
    @user_emotion.destroy
    respond_to do |format|
      format.html { redirect_to user_emotions_url, notice: "User emotion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_emotion
      @user_emotion = UserEmotion.find(params[:id])
    end

    def user_emotion_params
      p = params.require(:user_emotion).permit(:emotion_id, :description, :reported_on, :team_user_id)
      p[:user_id] = @team_user.user_id
      p[:team_id] = @team_user.team_id
      p
    end

    def set_team_user
      @team_user = current_user.team_users.find_by(team_id: params[:team_id])
    end
end
