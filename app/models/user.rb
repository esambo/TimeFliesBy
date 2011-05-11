class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:encryptable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :created_at
  
  has_many :tasks
  has_many :tags
  has_many :tag_tasks
end
