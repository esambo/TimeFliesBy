module AuthenticationHelpers
  # Based on: http://github.com/plataformatec/devise/blob/master/test/support/integration_tests_helper.rb
  def create_user(options={})
    @user ||= begin
      user = User.create!(
        :email => 'test@timefliesby.com',
        :password => 'secret',
        :password_confirmation => 'secret',
        :created_at => Time.now.utc
      )
      user.confirm! unless options[:confirm] == false
      user.lock! if options[:locked] == true
      user
    end
  end

  def sign_in_as_user(options={}, &block)
    user = create_user(options)
    visit new_user_session_path unless options[:visit] == false
    fill_in 'email', :with => 'test@timefliesby.com'
    fill_in 'password', :with => 'secret'
    check 'remember me' if options[:remember_me] == true
    yield if block_given?
    click_button 'Sign In'
    user
  end
end
World AuthenticationHelpers