class UsersController < ApplicationController
  load_and_authorize_resource
  
  def inform
    #@user = User.first
    #UserNotifier.send_signup_email(@user).deliver
    #redirect_to(assays_path)
    #flash.keep[:success] = "Mail sent!"
    ####
    hdr = SmtpApiHeader.new

    receiver = ['marc.lechuga@inserm.fr', 'mlechuga@icloud.com', 'marclechuga@free.fr']

    hdr.addTo(receiver)
    hdr.setUniqueArgs({'test' => 1, 'foo' =>2})
    hdr.setCategory('yourCategory')

  mail = Mail.deliver do
  header['X-SMTPAPI'] =  hdr.asJSON()
  to 'willnotdeliver@domain.com' # When using SMTPAPI's 'to' parameter, this address will not get delivered to
  from 'marc.lechuga@inserm.fr'
  subject 'Ruby Example using X-SMTPAPI header'
  text_part do
    body 'You would put your content here, but I am going to say: Hello world!'
  end
  html_part do
    content_type 'text/html; charset=UTF-8'
    body '<b>Hello world!</b><br>Glad to have you here!'
  end
end

  end
end
