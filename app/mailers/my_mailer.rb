class MyMailer < ActionMailer::Base  
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  # default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views


  def sermon_email(user, sermon, text)
    @user = user
    @sermon = sermon
    @text = text
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: @sermon.Title + ' - ' + sermon.Date.to_s , from: "'Sermon App Email' <notifications@my_site.com>")
  end
end