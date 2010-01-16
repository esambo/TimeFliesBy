#include Devise::TestHelpers
#
#  sign_in :user, @user   # sign_in(scope, resource)
#  sign_in @user          # sign_in(resource)
#
#  sign_out :user         # sign_out(scope)
#  sign_out @user         # sign_out(resource)

#  user = User.create! do |u|
#    u.email = 'user@test.com'
#    u.password = 'user123'
#    u.password_confirmation = 'user123'
#  end
#  user.confirm!
