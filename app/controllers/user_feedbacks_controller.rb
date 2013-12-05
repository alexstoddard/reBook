class UserFeedbacksController < ApplicationController
  #load_and_authorize_resource
  before_action :set_user_feedback, only: [:show, :edit, :update, :destroy]
  before_action :load_user_feedback, only: :create
  load_and_authorize_resource

  # GET /user_feedbacks
  # GET /user_feedbacks.json
  def index
    @user_feedbacks = UserFeedback.all
  end

  # GET /user_feedbacks/1
  # GET /user_feedbacks/1.json
  def show
  end

  # GET /user_feedbacks/new
  def new
    @user_feedback = UserFeedback.new
  end

  # GET /user_feedbacks/1/edit
  def edit
  end

  # POST /user_feedbacks
  # POST /user_feedbacks.json
  def create
    user_from_id = params[:user_feedback][:user_from_id].to_i
    user_to_id = params[:user_feedback][:user_to_id].to_i
    trade_id = params[:user_feedback][:trade_id].to_i
    #check that a feedback for this same trade and pair of users does not already exist
    if UserFeedback.where('user_from_id = ? and user_to_id = ? and trade_id = ?', user_from_id, user_to_id, trade_id).count == 0
      @user_feedback = UserFeedback.new(user_feedback_params)
      success = @user_feedback.save
      # if this is the last feedback (feedback count for this user = number of tradelines - 1)
      if UserFeedback.where('user_from_id = ? and trade_id = ?', user_from_id, trade_id).count == Trade.find(trade_id).trade_lines.count - 1
        Trade.find(trade_id).set_feedback_status(user_from_id)
      end
    else 
      success = false
    end

    respond_to do |format|
      if success
        format.html { redirect_to @user_feedback, notice: 'User feedback was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_feedback }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_feedbacks/1
  # PATCH/PUT /user_feedbacks/1.json
  def update
    respond_to do |format|
      if @user_feedback.update(user_feedback_params)
        format.html { redirect_to @user_feedback, notice: 'User feedback was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_feedbacks/1
  # DELETE /user_feedbacks/1.json
  def destroy
    @user_feedback.destroy
    respond_to do |format|
      format.html { redirect_to user_feedbacks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_feedback
      @user_feedback = UserFeedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_feedback_params
      params.require(:user_feedback).permit(:user_from_id, :user_to_id, :trade_id, :score)
    end

    def load_user_feedback
      @user_feedback = UserFeedback.new(user_feedback_params)
    end
end
