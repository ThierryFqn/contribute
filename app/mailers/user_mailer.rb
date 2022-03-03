class UserMailer < ApplicationMailer
  default from:'contact@localcontribute.com'

  def send_confirmation(user)
    @user = user
    @email = SibApiV3Sdk::SendSmtpEmail.new
    # Setup email attributes
    @email.sender = {
      "name": "Contribute",
      "email": "contact@contribute.com"
    }
    @email.to = [{ "email": @user.email }]
    @email.html_content = html
    @email.text_content = "String with your plain text email"
    @email.subject = "Your subject line"
    # @email.reply_to = {
    #   "email": "yourname@example.com",
    #   "name": "Your name"
    # }
    # Send your email
    @send_in_blue.send_transac_email(@email)
    # mail(to: user.email, subject: "Welcome")
  end

  def html
    render 'user_mailer/send_confirmation'
  end
end
