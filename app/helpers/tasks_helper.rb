module TasksHelper

  def human_duration(seconds)
    if seconds == 0
      '0s'
    else
      ChronicDuration.output seconds, :format => :short
    end
  end
  
  def microformats_duration(seconds)
    Duration.new(seconds).iso8601
  end
  
  def human_datetime(date_and_time)
    I18n.l(date_and_time, :format => :nice) unless date_and_time.nil?
  end
  
  def microformats_datetime(date_and_time)
    date_and_time.iso8601 unless date_and_time.nil?
  end

end
