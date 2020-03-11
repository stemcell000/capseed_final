class UserNotifier < ApplicationMailer
   default :from => 'mailer@capseed.net'

  def notify_assay(user)   
    @user = user
    
    recipients = User.where(:cloning_notify => true ).where.not(:role => "guest").pluck(:email)
    firstnames = User.where(:cloning_notify => true ).where.not(:role => "guest").pluck(:firstname)
    
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    
    mail :from => "mailer@capseed.com", :to => "noreply@address.com", :subject => "Cloning Notification"
  end
 
  def notify_production(user)
    
    recipients = User.where( :production_notify => true).where.not(:role => "guest").pluck(:email)
    firstnames = User.where( :production_notify => true ).where.not(:role => "guest").pluck(:firstname)
    
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    
    mail :from => "mailer@capseed.com", :to => "noreply@address.com", :subject => "Production Notification"
  end
  
   def notify_closed_assay(assay)
    
    recipients = User.where( :role => [ "administrator" ]).pluck(:email)
    firstnames = User.where( :role => [ "administrator" ] ).pluck(:firstname)
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    sendgrid_unique_args :key => assay.id
    
    mail :from => "mailer@capseed.com", :to => "noreply@address.com", :subject => "Cloning ##{assay.id} is closed."
  end
  
  
  def notify_closed_production(production)
    
    recipients = User.where( :role => [ "administrator" ]).pluck(:email)
    firstnames = User.where( :role => [ "administrator" ] ).pluck(:firstname)
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    sendgrid_unique_args :key => production.id
    
    mail :from => "mailer@capseed.com", :to => "noreply@address.com", :subject => "Production ##{production.id} is closed."
  end
  
end
