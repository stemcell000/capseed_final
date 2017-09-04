class ApplicationMailer < ActionMailer::Base
  include SendGrid
  default from: "from@example.com"
  layout 'mailer'
  
  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack
  sendgrid_unique_args :key1 => "value1", :key2 => "value2"
  

#Ne peut fonctionner qu'en production sur Heroku
  def notice(user)
    @user = user
    recipients = User.all.where(:role => "user").pluck(:email)
    sendgrid_category "Notification"
    sendgrid_recipients [recipients]
    mail :from => "noticeg@capseed.com", :to => "noreply@address.com", :subject => "Notification"
  end

end
