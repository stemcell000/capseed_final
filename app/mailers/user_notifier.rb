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
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Cloning')
 end
 
  def notify_production(user) 
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Production')
  end
  
end
