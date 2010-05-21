class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :recoverable, :registerable, :rememberable, :trackable, :validatable, :lockable
  attr_accessible :email, :password, :password_confirmation
  has_many :tasks
end
