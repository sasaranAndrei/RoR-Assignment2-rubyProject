require 'date'
class TimeTable

  DATE_TIME_FORMAT = "%d/%m/%Y_%H:%M"
  TIME_FORMAT = "%H:%M"  
  DAY_OF_WEEK_FORMAT = "%A"
  DEFAULT_DATE = DateTime.parse("19-04-2021")
  DEFAULT_START_PROGRAM = {
    :Monday => DateTime.parse("1-1-1_08:00"),
    :Tuesday => DateTime.parse("1-1-1_08:00"),
    :Wednesday => DateTime.parse("1-1-1_08:00"),
    :Thursday => DateTime.parse("1-1-1_08:00"),
    :Friday => DateTime.parse("1-1-1_08:00")
  }
  DEFAULT_END_PROGRAM = {
    :Monday => DateTime.parse("1-1-1_20:00"),
    :Tuesday => DateTime.parse("1-1-1_20:00"),
    :Wednesday => DateTime.parse("1-1-1_20:00"),
    :Thursday => DateTime.parse("1-1-1_20:00"),
    :Friday => DateTime.parse("1-1-1_16:00")
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
  
  def compute_next_monday(date) # initial [1,2,3] pt ca aici intra doar daca e weekend
    [0, 1, 2, 3, 4, 5, 6].each {|offset|
      new_date = date + offset
      return new_date if new_date.monday?
    }
  end

  def find_next_work_date(date)
    # get next monday...  
    if weekend_condition(date)
      next_monday = compute_next_monday(date)
      monday_start_time = start_program[:Monday].strftime(TIME_FORMAT)
      monday_hours = monday_start_time[0..1].to_i
      monday_minutes = monday_start_time[3..4].to_i
      
      monday = DateTime.new(next_monday.year, next_monday.month, next_monday.day, monday_hours, monday_minutes, 0, next_monday.zone)
      return monday
    end
    
    day_of_week = find_day_of_week(date)
    time = date.strftime(TIME_FORMAT)
    start_time = start_program[day_of_week].strftime(TIME_FORMAT)
    end_time = end_program[day_of_week].strftime(TIME_FORMAT)
    # TODO: REFACTOR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    down_new_hour = start_time[0..1].to_i
    down_new_minute = start_time[3..4].to_i

    up_new_hour = end_time[0..1].to_i
    up_new_minute = end_time[3..4].to_i

    next_day = date.next_day
    #puts time, start_time, end_time
    # new_start = DateTime.new(date.year,)
    return DateTime.new(date.year, date.month, date.day, down_new_hour, down_new_minute, 0, date.zone) if time < start_time
    return DateTime.new(next_day.year, next_day.month, next_day.day, up_new_hour, up_new_minute, 0, next_day.zone) if time > end_time

  end
  
  def try_find_next_work_date(date)
    while(out_of_program(date))
      date = increment_by_minute(date)
    end
    date
  end

  def increment_by_minute(date)
    #FOARTE APROAPE!!!
    time = date.strftime(TIME_FORMAT)
    new_hour = Integer(time[0..1])
    new_minute = Integer(time[3..4]) + 1

    new_date = DateTime.new(date.year, date.month, date.day, new_hour, new_date, 0, date.zone)
    #date + 60 #incrementeaza cu zile... nu am reusit sa fac cu minute
    new_date
    
  end

  

    
end