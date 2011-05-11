class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :tag_tasks
  has_many :tasks, :through => :tag_tasks
  validates_presence_of :user_id, :name
end
