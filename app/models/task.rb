require 'chronic_duration'

class Task < ActiveRecord::Base
  belongs_to :user
  has_many :tag_tasks
  has_many :tags, through: :tag_tasks
  before_create :set_stop_on_last
  validates_presence_of :user
  validates_associated :user, message: 'Bad user association' #Doesn't seem to do anything...
  validates_datetime :start, on_or_after: '2000-01-01 08:00'
  validates_datetime :stop, allow_blank: true
  validate :valid_stop
  default_scope order('start desc')

  def duration
    (self[:stop].blank? ? Time.zone.now.to_i : self[:stop].to_i) - self[:start].to_i
  end

  def switch_now(time = Time.zone.now)
    switch_at time
  end
  
  def switch_at(time)
    self[:start] = time
  end
  
  def set_stop_on_last
    previous_task = user.tasks.where("stop IS NULL").first
    if previous_task
      previous_task.stop = self[:start]
      previous_task.save!
    elsif self[:title] != 'Error: Time gap!'
      previous_task = user.tasks.where("stop < ?", self[:start]).first
      if previous_task
        gap = Task.create!(
          title:   'Error: Time gap!',
          start:   previous_task.stop,
          stop:    self[:start],
          user_id: self[:user_id]
        )
      end
    end
  end

  def switch_to(time = Time.zone.now)
    # Prevent Postgresql error where it passes the :id with null
    new_task_attributes = self.dup.attributes
    new_task_attributes.delete('id')
    new_task = Task.new(new_task_attributes)
    new_task.switch_now(time)
    new_task[:stop]         = nil
    new_task.stop           = nil
    # some manual fixes that should not be necessary in Rails 3.1 anymore
    new_task[:created_at]   = time
    new_task[:modified_at]  = time
    # deep copy associations
    # look into gem: deep_cloneable
    self.tags.each do |t|
      new_task.tags.push t
    end
    new_task
  end
  
  def valid_stop
    unless self[:stop].blank?
      if self[:stop] < self[:start]
        errors.add :stop, 'needs to be greater than start.'
      end
    end
  end

end
