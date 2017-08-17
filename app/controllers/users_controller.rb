class UsersController < ApplicationController
  def inform
    @user = User.first
    SeedMailer.seed_email(@user).deliver
    redirect_to(assays_path)
    flash.keep[:success] = "Mail sent!"
  end
end
