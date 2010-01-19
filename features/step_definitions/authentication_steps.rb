#include Devise::TestHelpers
#
#  sign_in :user, @user   # sign_in(scope, resource)
#  sign_in @user          # sign_in(resource)
#
#  sign_out :user         # sign_out(scope)
#  sign_out @user         # sign_out(resource)

require File.join(File.dirname(__FILE__),  ".." ,"support" ,"authentication_helpers" )

Given /^I registered as a new user$/ do
  visit path_to "the home page"
  click_link "Register"
  fill_in "email", :with => "test@timefliesby.com"
  fill_in "password", :with => "secret"
  fill_in "password confirmation", :with => "secret"
  click_button "Register"
end

Given /^I am a registered user$/ do
  create_user
end

Given /^I am signed in as a user$/ do
  sign_in_as_user
end

When /^I follow "([^\"]*)" in the "([^\"]*)" email$/ do |link_name, subject|
  ActionMailer::Base.deliveries.size.should == 1
  email = ActionMailer::Base.deliveries.first
  email.subject.should match(subject)
  match = email.body.match Regexp.new("<a href=\"(http:.+)\">#{link_name}<\/a>")
  link_url = match[1]
  link_url.should match("confirmation_token")
  visit link_url
#  require 'webrat/core/scope'
#  webrat_email = Webrat::Scope.from_page(session, response, email.body)
#  webrat_email.click_link link_name
end
