class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit_user, :update, :destroy]
  
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def inform_cloning
    @user = User.first
    UserNotifier.notify_assay(@user).deliver_now
    redirect_to(assays_path)
    flash.keep[:success] = "Mail sent to cloning users!"
  end
  
  def inform_production
    @user = User.first
    UserNotifier.notify_production(@user).deliver_now
    redirect_to(productions_path)
    flash.keep[:success] = "Mail sent to production users!"
  end
  
 def index
    @users = smart_listing_create(:users, User.all, partial: "users/list", default_sort: {:username => "asc"},  page_sizes: [20, 30, 50, 100])   
  end

  def show
  end
  
  def new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
        flash.keep[:success] = "User created!"
        @user.create_option
     else
        render action: :new
    end
  end

  def update
     @user.update_attributes(user_params)
     if @user.valid?
        flash.keep[:success] = "User updated!"
     else
        render action: :new
    end
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
  
  def edit_notif
    @user = current_user
  end
  
  def update_notif
      @user = current_user
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "edit_notif"
    end
  end
  
 def actual_member_switch
  @user.toggle! :actual_member
  @users = smart_listing_create(:users, User.all, partial: "users/list", default_sort: {:username => "asc"},  page_sizes: [20, 30, 50, 100])
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:id, :email, :firstname, :lastname, :username, :role, :cloning_notify, :production_notify, :password, :password_confirmation, :current_password, :actual_member)
    end
    
end
