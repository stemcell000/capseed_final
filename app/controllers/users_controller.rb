class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  
  def inform_cloning
    @user = User.first
    UserNotifier.notify_cloning(@user).deliver_now
    redirect_to(assays_path)
    flash.keep[:success] = "Mail sent to cloning users!"
  end
  
  def inform_production
    @user = User.first
    UserNotifier.notify_production(@user).deliver_now
    redirect_to(productions_path)
    flash.keep[:success] = "Mail sent to production users!"
  end
  
# GET /users
  # GET /users.json
  def index
    @users = User.all.where.not(:role => "administrator")
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end
  # GET /users/new
  def new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save(:validate => false)
        format.html { redirect_to @user }
        format.json { render :create, status: :created, location: @user }
        format.js { render :create, status: :created, location: @user }
        flash[:success] = 'User was successfully created.'
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    @users = User.all
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def edit
    @user = current_user
  end
  
  def edit_user
  end
  
  def update_password
    @user = current_user
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "edit"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :username, :role, :password, :password_confirmation, :current_password)
    end
  
end
