class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit_user, :update, :destroy]
  
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
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
    @users = smart_listing_create(:users, User.all, partial: "users/list", default_sort: {:username => "asc"},  page_sizes: [10, 20, 30, 50, 100])   
  end

  def show
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def update
     @user.update_attributes(user_params)
  end

  def destroy
    @user.destroy
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
  
 def actual_member_switch
  @user.toggle! :actual_member
  @users = smart_listing_create(:users, User.all, partial: "users/list", default_sort: {:username => "asc"},  page_sizes: [10, 20, 30, 50, 100])
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :username, :role, :cloning_notify, :production_notify, :password, :password_confirmation, :current_password, :actual_member)
    end
  
end
