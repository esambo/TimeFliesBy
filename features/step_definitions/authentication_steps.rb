#include Devise::TestHelpers
#
#  sign_in :user, @user   # sign_in(scope, resource)
#  sign_in @user          # sign_in(resource)
#
#  sign_out :user         # sign_out(scope)
#  sign_out @user         # sign_out(resource)

require File.join(File.dirname(__FILE__),  ".." ,"support" ,"authentication_helpers" )

Given /^I registered as a new user$/ do
  visit path_to("/the home page")
  click_link "Register"
  fill_in "user_email", :with => "test@timefliesby.com"
  fill_in "user_password", :with => "secret"
  fill_in "user_password_confirmation", :with => "secret"
  click_button "Register"
end

Given /^I am a registered user$/ do
  create_user
end

Given /^I am signed in as a new user$/ do
  sign_in_as_new_user
end

Given /^I am signed in as a new user "([^\"]*)"$/ do |email|
  sign_in_as_new_user :email => email
end

When /^I follow "([^\"]*)" in the "([^\"]*)" email$/ do |link_name, subject|
#  ActionMailer::Base.deliveries.size.should == 1
#  email = ActionMailer::Base.deliveries.first
#  email.subject.should match(subject)
#  match = email.body.match Regexp.new("<a href=\"(http:.+)\">#{link_name}<\/a>")
#  link_url = match[1]
#  link_url.should match("confirmation_token")
#  visit link_url

  # Based on: http://github.com/bmabey/email-spec/blob/master/examples/rails_root/features/step_definitions/user_steps.rb
  unread_emails_for(current_email_address).size.should == 1

  # this call will store the email and you can access it with current_email
  open_last_email_for(last_email_address)
  current_email.should have_subject(subject)
  current_email.should have_body_text('You can confirm your account through the link below:')

  visit_in_email link_name
end
