class ApplicationMailer < ActionMailer::Base
  include SendGrid
  default from: "from@example.com"
  layout 'mailer'
  
  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack
  sendgrid_unique_args :key1 => "value1", :key2 => "value2"
  sendgrid_recipients ["marclechuga@inserm.fr", "mlechuga@icould.com", "marclechuga@free.fr"]

  def welcome_message(user)
    @user = user
    sendgrid_category "Welcome"
    sendgrid_recipients ["marclechuga@inserm.fr", "mlechuga@icould.com", "marclechuga@free.fr"]
    mail :to => sendgrid_recipients, :subject => "Welcome #{user.firstname} :-)"
  end

  def goodbye_message(user)
    sendgrid_disable :ganalytics
    mail :to => user.email, :subject => "Fare thee well :-("
  end
end
