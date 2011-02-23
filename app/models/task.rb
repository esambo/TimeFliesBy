require 'chronic_duration'

class Task < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user
  validates_associated :user, :message => 'Bad user association' #Doesn't seem to do anything...
  attr_accessor :first_task
  validates_datetime :start, :on_or_after => '2000-01-01 08:00'
  validates_datetime :stop,  :on_or_before => 3.months.from_now #, :allow_blank => true
  validate :valid_stop

#  # works, but I don't really need it!
#  def after_initialize
#    @first_task = false
#  end

  def duration
    ChronicDuration.output((self[:stop] - self[:start]).round, :format => :chrono) if valid?
  end

  def now(time = Time.zone.now)
    self[:stop] = time
    if self[:start].blank?
    # previous_task = user.tasks.first(:order => "start DESC", :conditions => ["stop <= ? AND stop IS NOT NULL", Time.zone.now])
      previous_task = user.tasks.first(:order => "start DESC", :conditions => ["stop <= ?", time.to_s(:db)])
    end
    if previous_task && !previous_task.stop.blank?
      self[:start] = previous_task.stop
      @first_task = false
    elsif self[:start].blank?
      self[:start] = time
      @first_task = true
    end
  end

  def valid_stop
    if !self[:stop].blank? && self[:stop] < self[:start]
      errors.add :stop, 'needs to be greater than start.'
    end
  end

end
