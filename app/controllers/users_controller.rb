class UsersController < ApplicationController
  load_and_authorize_resource
  
  def inform
    @user = User.first
    SeedMailer.seed_email(@user).deliver
    #users = User.where(:role => "user").all
    #users.each do |user|
     # SeedMailer.seed_email(user).deliver
    #end
    redirect_to(assays_path)
    flash.keep[:success] = "Mail sent!"
  end
end
