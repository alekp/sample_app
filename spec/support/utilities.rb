# def full_title(page_title)
#   base_title = "Ruby on Rails Tutorial Sample App"
#   if page_title.empty?
#     base_title
#   else
#     "#{base_title} | #{page_title}"
#   end
# end
include ApplicationHelper

# added for Hellipn RSpec tests

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end


# http://ruby.railstutorial.org/chapters/sign-in-sign-out#sec-rspec_custom_matchers
# decouple  page.should have_selector('div.alert.alert-error', text: message) if CSS Class changes so one place modification in RSpec similar as Cucumber
RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

# file added manualy