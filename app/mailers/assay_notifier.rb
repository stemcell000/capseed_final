class AssayNotifier < ApplicationMailer
  
  def notify_closed_assay(assay)
    #TUTO: ligne suivante nécessaire pour passer des variables (attributs de @production) dans le corps du message. 
    @assay = assay
    recipients = User.where( :role => [ "administrator" ]).pluck(:email)
    firstnames = User.where( :role => [ "administrator" ] ).pluck(:firstname)
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    sendgrid_unique_args :key => assay.id
    
    mail :from => "mailer@capseed.com", :to => "noreply@address.com", :subject => "Cloning ##{assay.id} is closed."
  end
  
end