class PostmanMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.postman_mailer.signup_notification.subject
  #
  def signup_notification(object)
    @object = object

    mail to: "#{@object.email}", subject: "#{@object.class} created successfully."
  end

  def reset_password_notification(user, new_password)
    @user = user
    @new_password = new_password
    mail to: "#{@user.email}", subject: "Reset your password"
  end

end
