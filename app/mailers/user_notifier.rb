class UserNotifier < ApplicationMailer
   default :from => 'mailer@capseed.net'

  def notify_cloning(user)   
    @user = user
    
    recipients = User.where(:role => ["cloning_user", "user"] ).pluck(:email)
    firstnames = User.where(:role => ["cloning_user", "user"] ).pluck(:firstname)
    
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    
    mail :from => "mailer@capseed.net", :to => "noreply@address.com", :subject => "Cloning Notification"
  end
 
  def notify_production(user)
    
    recipients = User.where( :role => [ "production_user", "user" ]).pluck(:email)
    firstnames = User.where( :role => [ "production_user", "user" ] ).pluck(:firstname)
    
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    
    mail :from => "mailer@capseed.net", :to => "noreply@address.com", :subject => "Production Notification"
  end
  
  def notify_closed_production(production)
    
    recipients = User.where( :role => [ "administrator" ]).pluck(:email)
    firstnames = User.where( :role => [ "administrator" ] ).pluck(:firstname)
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    sendgrid_unique_args :key => production.id
    
    mail :from => "mailer@capseed.net", :to => "noreply@address.com", :subject => "Production is closed ('#{production.id}')."
  end
  
end
