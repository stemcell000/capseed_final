class UserNotifier < ApplicationMailer
   default :from => 'marc.lechuga@inserm.fr'


  
  def notify_cloning(user)   
    @user = user
    
    recipients = User.where(:role => "cloning_user" ).pluck(:email)
    firstnames = User.where(:role => "cloning_user" ).pluck(:firstname)
    
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    
    mail :from => "mailer@capseed.net", :to => "noreply@address.com", :subject => "Cloning Notification"
  end
 
  def notify_production(user) 
    recipients = User.where( :role => "production_user", :role => "user" ).pluck(:email)
    firstnames = User.where( :role => "production_user", :role => "user" ).pluck(:firstname)
    
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    
    mail :from => "mailer@capseed.net", :to => "noreply@address.com", :subject => "Production Notification"
  end
  
end
