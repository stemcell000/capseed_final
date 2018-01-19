class ProductionNotifier < ApplicationMailer
  
  def notify_closed_production(production)
    #TUTO: ligne suivante nécessaire pour passer des variables (attributs de @production) dans le corps du message. 
    @production = production
    recipients = User.where( :role => [ "administrator" ]).pluck(:email)
    firstnames = User.where( :role => [ "administrator" ] ).pluck(:firstname)
    sendgrid_category "Notification"
    
    sendgrid_recipients recipients
    sendgrid_substitute "|subme|", firstnames
    sendgrid_unique_args :key => production.id
    
    mail :from => "mailer@capseed.net", :to => "noreply@address.com", :subject => "Production ##{production.id} is closed."
  end
  
end
