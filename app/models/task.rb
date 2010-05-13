require 'chronic_duration'

class Task < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user
  validates_associated :user, :message => 'Bad user association' #Doesn't seem to do anything...
  attr_accessor :first_task
  validates_datetime :start, :on_or_after => '2000-01-01T08:00:00-0600'
  validates_datetime :stop,  :on_or_before => 3.months.from_now #, :allow_blank => true
  validate :valid_stop

  def initial
    self.first_task = false
  end

  def duration
    ChronicDuration.output((stop - start).round, :format => :chrono) if valid?
  end

  def now time = Time.now
    self.stop = time
    if self.start.blank?
#      previous_task = Task.first(:order => "start DESC", :conditions => ["stop <= ? AND stop IS NOT NULL", Time.zone.now])
      previous_task = self.user.tasks.first(:order => "start DESC", :conditions => ["stop <= ?", time])
    end
    if previous_task && !previous_task.stop.blank?
      self.start = previous_task.stop
      self.first_task = false
    else
      self.start = time
      self.first_task = true
    end
  end

  def valid_stop
    if !stop.blank? && Time.parse(stop.to_s) < Time.parse(start.to_s)
#    if !stop.blank? && stop < start
      errors.add :stop, 'needs to be greater than start.'
    end
  end

end
