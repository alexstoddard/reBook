class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_locations, only: [:edit, :update, :create, :new]
  before_action :set_params, only: [:update, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
  def matches
    sql = "select u1.username as user_from, u2.username as user_to, b1.thumbnail as from_thumb, b1.name as from_title, b2.name as to_title, b2.thumbnail as to_thumb from inventory_owns o1, inventory_needs n1, books b1, users u1, inventory_owns o2, inventory_needs n2, books b2, users u2 where u1.id = o1.user_id and o1.book_id = n1.book_id and b1.id = o1.book_id and o2.user_id = n1.user_id and n1.user_id = u2.id and n2.book_id = o2.book_id and b2.id = o2.book_id and n2.user_id = o1.user_id and o1.user_id =" + session[:user_id].to_s
    @records = ActiveRecord::Base.connection.execute(sql)
 end
  # GET /users/1
  # GET /users/1.json
  def show
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
      @location_params = { :location_id => user_params[:location], :description => user_params[:location_description] }
      user_params[:location] = nil
      user_params[:location_description] = nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first, :last, :username, :email, :passhash, :image, :activated, 
                                   :passhash_confirmation, :location, :location_description, :terms)
    end
end
