class UsersController < ApplicationController
  load_and_authorize_resource
  
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
  
  def inform_closed_production
    @user = User.first
    UserNotifier.notify_closed_production(@user).deliver_now
    #redirect_to(assays_path)
    flash.keep[:success] = "Mail sent to administrators!"
  end
  
end
