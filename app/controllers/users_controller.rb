class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_locations, only: [:edit, :update, :create, :new]
  before_action :set_params, only: [:update, :create]
  before_action :set_is_current_user, only: [:show]

  def set_is_current_user
    @is_current_user = is_current_user(@user.id)
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /forgot
  # GET /forgot.json
  def forgot
  end
  
  def edit_schedule
    @user = User.find(session[:user_id])
  end

  # POST /forgot
  # POST /forgot.json
  def forgot_do

    @user = User.find_by_username(params[:username])
    @user ||= User.find_by_email(params[:username])
    
    unless @user.nil?
      UserMailer.reset_email(@user).deliver
      redirect_to root_path
      flash[:notice] = "An email has been sent to your account, check it to reset your password."
    else
      flash[:reset_error] = params[:username] + " does not match an account in our system."
      redirect_to forgot_path
    end

  end

  # GET /reset
  # GET /reset.json
  def reset
    if params[:token] != nil
      @user = User.find_by_token(params[:token])
      if @user.nil?
        flash[:reset_error] = "Could not reset password"
        redirect_to forgot_path
      end
    end
  end

  # patch /reset
  # patch /reset.json
  def reset_do

    @user = User.find(params[:post][:id])
    @user.passhash = params[:post][:passhash]
    @user.passhash_confirmation = params[:post][:passhash_confirmation]
    @user.token = nil

    if @user.save
      flash[:password_changed] = 'Password was successfully reset. Login now.'
      redirect_to login_path
    else
      render action: 'reset'
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user_location = UserLocation.new
    @user_locations = UserLocation.all

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user.location = UserLocation.find_by_user_id(params[:id]).location_id
    @user.location_description = UserLocation.find_by_user_id(params[:id]).description
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.create_with_location(user_params, @location_params)

    respond_to do |format|
      if @user.errors.size == 0
        format.html { redirect_to root_path, notice: 'Account has been created. Check your email to activate.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: nil, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_locations
      @locations = Location.all
    end

    def set_params
      @location_params = { :location_id => user_params[:location].to_i, :description => user_params[:location_description] }
      user_params[:location] = nil
      user_params[:location_description] = nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first, :last, :username, :email, :passhash, :image, :activated, 
                                   :passhash_confirmation, :location, :location_description, :terms)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.permit(:location_id, :description)
    end
    
end
