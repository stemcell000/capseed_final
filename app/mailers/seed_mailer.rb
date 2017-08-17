class SeedMailer < ApplicationMailer
  
  default from: "marc.lechuga@inserm.fr"
  
  def seed_email(user)
    @user = user
    mail :to => user.email, :subject => "Message from Capseed!"
  end
  
end
