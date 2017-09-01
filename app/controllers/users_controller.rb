class UsersController < ApplicationController
  load_and_authorize_resource
  
  def inform
    @user = User.first
    UserMailer.send_signup_email(@user).deliver
    redirect_to(assays_path)
    flash.keep[:success] = "Mail sent!"
  end
end
