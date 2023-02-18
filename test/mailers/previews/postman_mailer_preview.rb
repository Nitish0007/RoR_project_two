# Preview all emails at http://localhost:3000/rails/mailers/postman_mailer
class PostmanMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/postman_mailer/signup_notification
  def signup_notification
    PostmanMailer.signup_notification
  end

end
