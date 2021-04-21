require 'date'
require 'time'
class TimeTable
  DATE_TIME_FORMAT = "%d/%m/%Y_%H:%M"
  TIME_FORMAT = "%H:%M"  
  DAY_OF_WEEK_FORMAT = "%A"
  MINUTE = 60
  DEFAULT_DATE = Time.parse("19-04-2021")
  DEFAULT_START_PROGRAM = {
    :Monday => Time.parse("1-1-1_08:00"),
    :Tuesday => Time.parse("1-1-1_08:00"),
    :Wednesday => Time.parse("1-1-1_08:00"),
    :Thursday => Time.parse("1-1-1_08:00"),
    :Friday => Time.parse("1-1-1_08:00")
  }
  DEFAULT_END_PROGRAM = {
    :Monday => Time.parse("1-1-1_20:00"),
    :Tuesday => Time.parse("1-1-1_20:00"),
    :Wednesday => Time.parse("1-1-1_20:00"),
    :Thursday => Time.parse("1-1-1_20:00"),
    :Friday => Time.parse("1-1-1_16:00")
  }

  attr_accessor :start_program, :end_program


  def initialize()
    @start_program = DEFAULT_START_PROGRAM
    @end_program = DEFAULT_END_PROGRAM
  end

  def find_day_of_week(date)
    day_of_week = date.strftime(DAY_OF_WEEK_FORMAT)
    day_of_week.to_sym
  end

  def out_of_program(date)
    day_of_week = find_day_of_week(date)
    start_date = start_program[day_of_week]
    end_date = end_program[day_of_week]
    out_of_program_condition(date, start_date, end_date)
  end

  def out_of_program_condition(date, start_date, end_date)
    weekend_condition(date) || out_of_program_hours_condition(date, start_date, end_date)
  end

  def out_of_program_hours_condition(date, start_date, end_date)
    #return true if start_date.nil? || end_date.nil?
    time = date.strftime(TIME_FORMAT)
    start_time = start_date.strftime(TIME_FORMAT)
    end_time = end_date.strftime(TIME_FORMAT)
    #puts time, start_time, end_time
    return true if time < start_time
    return true if time > end_time
    false
  end

  def weekend_condition(date)
    return true if date.saturday? || date.sunday?
    # edge case => friday afternoon
    time = date.strftime(TIME_FORMAT)
    end_time = end_program[:Friday].strftime(TIME_FORMAT)
    # puts time, end_time
    return true if date.friday? && time > end_time
  end
  
  def find_next_work_date(date)
    while(out_of_program(date))
      date = increment_by_minute(date)
    end
    date
  end

  def increment_by_minute(date)
    new_date = date + 1 * MINUTE
    return new_date
  end

  

    
end