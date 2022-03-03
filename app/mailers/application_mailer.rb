class ApplicationMailer < ActionMailer::Base

  def initialize
    @send_in_blue = SibApiV3Sdk::TransactionalEmailsApi.new
  end

  default from: 'from@example.com'
  layout 'mailer'
end
