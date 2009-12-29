class Task < ActiveRecord::Base
  validates_datetime :start, :on_or_after => '1/1/2000 8:00 am'
  validates_datetime :stop,  :on_or_after => '1/1/2000 8:00 am'
  
end
