module TasksHelper
  include DateTimeHelper
  
  def human_date_time(date_and_time)
    if date_and_time.nil?
      'Active'
    else
      editable_date_time date_and_time
    end
  end

end
