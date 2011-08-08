module DateTimeHelper

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
  
  def editable_date_time(date_and_time)
    I18n.l(date_and_time, :format => :nice) unless date_and_time.nil?
  end
  
  def microformats_date_time(date_and_time)
    date_and_time.iso8601 unless date_and_time.nil?
  end
  
  def parse_human_duration(duration_in_natural_language)
    ChronicDuration.parse(duration_in_natural_language) || 0
  end
  
  def parse_us_date_time(date_and_time)
    Timeliness.parse(date_and_time)
  end
  
end
