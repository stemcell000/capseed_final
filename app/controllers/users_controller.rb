class UsersController < ApplicationController
  load_and_authorize_resource
  
  def inform_cloning
    @user = User.find(1)
    UserMailer.notify_cloning(@user).deliver_now
    redirect_to(assays_path)
    flash.keep[:success] = "Mail sent to cloning users!"
  end
  
  def inform_production
    @user = User.first
    UserMailer.notify_production(@user).deliver_later
    redirect_to(productions_path)
    flash.keep[:success] = "Mail sent to production users!"
  end
  
end
