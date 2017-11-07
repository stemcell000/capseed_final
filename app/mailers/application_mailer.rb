class ApplicationMailer < ActionMailer::Base
  include SendGrid
  default from: "from@capseed.com"
  layout 'mailer'
  
  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack
  sendgrid_unique_args :key1 => "value1", :key2 => "value2"
  

#Ne peut fonctionner qu'en production sur Heroku
  def notice(user, role)
    @user = user
    
    recipients = User.all.where(:role => "user").where(:role => role).pluck(:email)
    firstnames = User.all.where(:role => "user").where(:role => role).pluck(:firstname)
    
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    
    mail :from => "notice@capseed.com", :to => "noreply@address.com", :subject => "Notification"
  end
  

end
