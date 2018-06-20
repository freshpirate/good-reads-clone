class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_user.subject
  #
  def new_user(user)
    @user = user
    
    mail to: @user.email,
         subject: "Confirm registration with Bad Reads"
  end

  def top_rated(books)
    @books = books

    recipients = User.all.collect(&:email).join(",")
    mail to: recipients,
         subject: "List of Top Rated books"
  end
end
