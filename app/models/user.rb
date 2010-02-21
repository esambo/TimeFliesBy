class User < ActiveRecord::Base
  devise :all
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation

  has_many :tasks
end
