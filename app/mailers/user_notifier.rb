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
    
    recipients = User.where( :role => [ "administrator", "user" ]).pluck(:email)
    firstnames = User.where( :role => [ "administrator", "user" ] ).pluck(:firstname)
    prod = Production.find(params[:id])
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    sendgrid_substitute "|prod|", production
    
    mail :from => "mailer@capseed.net", :to => "noreply@address.com", :subject => "Production is closed."
  end
  
end
