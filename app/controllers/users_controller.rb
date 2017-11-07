class UsersController < ApplicationController
  load_and_authorize_resource
  
  def inform_cloning
    @user = User.first
    UserMailer.notice(@user, "cloning_user").deliver
    redirect_to(assays_path)
    flash.keep[:success] = "Mail sent to cloning users!"
  end
  
  def inform_production
    @user = User.first
    UserMailer.notice(@user, "production_user").deliver
    redirect_to(productions_path)
    flash.keep[:success] = "Mail sent to production users!"
  end
  
end
