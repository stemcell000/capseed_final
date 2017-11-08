class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  
 def notify_cloning(user)   
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Cloning')
 end
 
  def notify_production(user) 
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Production')
  end
 
end
