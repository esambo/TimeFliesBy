ValidatesTimeliness.setup do |config|
  # Extend ORM/ODMs for full support (:active_record, :mongoid).
  config.extend_orms = [ :active_record ]

  # Default timezone
  config.default_timezone = :cst

  # Set the dummy date part for a time type values. (for a time-only type)
  config.dummy_date_for_time_type = [ 1999, 1, 1 ]

  # Ignore errors when restriction options are evaluated (By default these errors are displayed in Rails test mode)
  config.ignore_restriction_errors = false

  # Re-display invalid values in date/time selects (To activate it, uncomment)
  config.enable_date_time_select_extension!

  # Handle multiparameter date/time values strictly (To activate it, uncomment this line)
  config.enable_multiparameter_extension!

  # Shorthand date and time symbols for restrictions
  config.restriction_shorthand_symbols.update(
    :now   => lambda { Time.current },
    :today => lambda { Date.current }
  )

  # Use the plugin date/time parser which is stricter and extendable (uses gem: timeliness)
  config.use_plugin_parser = true
  
  # Add one or more formats making them valid. e.g. add_formats(:date, 'd(st|rd|th) of mmm, yyyy')
  config.parser.add_formats(
    :datetime, 'm/d/yy h:nn:ss_ampm'
  )

  # Remove one or more formats making them invalid. e.g. remove_formats(:date, 'dd/mm/yyy')
  # config.parser.remove_formats()

  # Change the amiguous year threshold when parsing a 2 digit year
  # config.parser.ambiguous_year_threshold =  30

  # Treat ambiguous dates, such as 01/02/1950, as a Non-US date.
  # config.parser.remove_us_formats
end
