class SeedMailer < ApplicationMailer
  
  default from: "marc.lechuga@inserm.fr"
  
  def seed_email(user)
    @user = user
    mail :to => "mlechuga@icloud.com", :subject => "Message from Capseed!"
  end
  
end
