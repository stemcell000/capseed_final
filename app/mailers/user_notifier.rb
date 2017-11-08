class UserNotifier < ApplicationMailer
   default :from => 'marc.lechuga@inserm.fr'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end
  
   def notify_cloning(user)   
    @user = user
    
    recipients = User.all.where(:role => "user").where(:role => "cloning_user").pluck(:email)
    firstnames = User.all.where(:role => "user").where(:role => "cloning_user").pluck(:firstname)
    
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    
    mail :from => "noticeg@capseed.com", :to => "noreply@address.com", :subject => "Notification"
  end
 
  def notify_production(user) 
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Production')
  end
  
end
