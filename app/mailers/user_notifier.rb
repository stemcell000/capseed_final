class UserNotifier < ApplicationMailer
   default :from => 'marc.lechuga@inserm.fr'


  
   def notify_cloning(user)   
    @user = user
    
    recipients = User.all.where(:role => "user").where(:role => "cloning_user").pluck(:email)
    firstnames = User.all.where(:role => "user").where(:role => "cloning_user").pluck(:firstname)
    
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    
    mail :from => "marc.lechuga@inserm.fr", :to => "noreply@address.com", :subject => "Cloning Notification"
  end
 
  def notify_production(user) 
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Production')
  end
  
end
