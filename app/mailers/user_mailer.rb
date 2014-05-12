class UserMailer < ActionMailer::Base
  #default from: "shawn@techmeetups.com"
  
  def ashish_mail(email)
  	email = email
  	mail(to: email, subject: "Test Job", body: "I am smart boy")
  end
end
