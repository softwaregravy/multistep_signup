class Notifications < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.signup.subject
  #
  def signup(user, password)
    @user = user 
    @password = password
    mail :to => user.email, :subject => "Your Signup"
  end
end
