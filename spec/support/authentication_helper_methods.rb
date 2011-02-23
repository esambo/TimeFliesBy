module AuthenticationHelperMethods

  # Based on: http://github.com/plataformatec/devise/blob/master/test/support/integration.rb

  def create_user(options={})
    @user = User.create!(
      :email                  => options[:email]                 || 'test@timefliesby.com',
      :password               => options[:password]              || 'secret',
      :password_confirmation  => options[:password_confirmation] || 'secret',
      :created_at             => options[:created_at]            || Time.now.utc
    )
    @user.confirm!             unless options[:confirm]            == false
    @user.lock!                if     options[:locked]             == true
    @user
  end

  def sign_in_as_user(options={}, &block)
    visit new_user_session_path unless    options[:visit]           == false
    fill_in 'user_email',       :with =>  options[:email]           || 'test@timefliesby.com'
    fill_in 'user_password',    :with =>  options[:password]        || 'secret'
    check   'user_remember_me'  if        options[:remember_me]     == true
    yield                       if        block_given?
    click_button 'Sign in'
  end

  def sign_in_as_new_user(options={}, &block)
    create_user(options)
    sign_in_as_user(options, &block)
  end

  def current_user
    @user
  end

end

# Alternative: Stub Warden: http://stackoverflow.com/questions/4212355/testing-controllers-in-rails-3-with-devise-and-rspec