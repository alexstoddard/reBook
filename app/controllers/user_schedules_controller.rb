class UserSchedulesController < ApplicationController
  load_and_authorize_resource
  before_action :set_user_schedule, only: [:show, :edit, :update, :destroy]

  # GET /user_schedules
  # GET /user_schedules.json
  def index
    @user_schedules = UserSchedule.all
  end

  # GET /user_schedules/1
  # GET /user_schedules/1.json
  def show
  end

  # GET /user_schedules/new
  def new
    @user_schedule = UserSchedule.new
  end

  # GET /user_schedules/1/edit
  def edit
  end

  # POST /user_schedules
  # POST /user_schedules.json
  def create
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    @user = current_user
    @user_location = @user.user_locations.find(params[:user_location_id])

    UserSchedule.transaction do
      
      days.each do |day|
        if params[day]
          @user_schedule = @user_location.user_schedules.build

          @user_schedule.to_standard = params[:to_standard] 
          @user_schedule.from_standard = params[:from_standard] 
          @user_schedule.day = day
          @user_schedule.save

        end
      end
    end

    respond_to :js

  end

  # PATCH/PUT /user_schedules/1
  # PATCH/PUT /user_schedules/1.json
  def update
    respond_to do |format|
      if @user_schedule.update(user_schedule_params)
        format.html { redirect_to @user_schedule, notice: 'User schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_schedules/1
  # DELETE /user_schedules/1.json
  def destroy
    @user_schedule.destroy

    @user = User.find(session[:user_id])
    @user_locations = UserLocation.find_all_by_user_id(session[:user_id])

    respond_to do |format|
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_schedule
      @user_schedule = UserSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_schedule_params
      params.permit(:from, :to, :day, :user_location_id)
    end
end
