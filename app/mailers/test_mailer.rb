class TestMailer < ApplicationMailer
  default from: 'test@example.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://swallet.com/'
    mail(to: @user.email, subject: 'Welcome to your Swallet')
  end
end
