class ApplicationMailer < ActionMailer::Base
  include SendGrid
  default from: "from@example.com"
  layout 'mailer'
  
  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack
  sendgrid_unique_args :key1 => "value1", :key2 => "value2"
  sendgrid_recipients ["marc.lechuga@inserm.fr", "lechuga@icould.com", "marclechuga@free.fr"]

#Ne peut fonctionner qu'en production sur Heroku
  def notice(user)
    @user = user
    sendgrid_category "Notification"
    sendgrid_recipients ["marclechuga@inserm.fr", "mlechuga@icould.com", "marclechuga@free.fr"]
    mail :from => "noticeg@capseed.com", :to => "noreply@address.com", :subject => "Notification"
  end

end
