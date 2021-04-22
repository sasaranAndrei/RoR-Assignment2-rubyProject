require_relative 'time_table'

class Station
  INVALID_INPUT_MESSAGE = "\nInvalid Station Input!\nPlease provide a nonzero positive number that represents number of process hours.\n\n"
  
  attr_accessor :process_hours, :schedule, :station_id
  @@station_count = 0 

  def initialize(process_hours)
    raise if invalid_input(process_hours)
    
    @station_id = @@station_count
    @@station_count += 1
    @process_hours = process_hours
    @schedule = Hash.new
  end

  def invalid_input(process_hours)
    process_hours <= 0
  end

  def to_s
    result = "Station : (station_id = #{ station_id }, process_hours = #{ process_hours }, schedule:\n)\n"
    schedule.each { |key, value| result += key.to_s + " -> " + value.to_s + "\n" }
    
    result
  end

  def appointments
    result = ""
    schedule.each do |date, car|
      result += "Car#" + car.car_id.to_s
      result += " was schedule on " + car.schedule_date.strftime(TimeTable::DATE_TIME_FORMAT)
      result += ". Pick-up Date: " + process(date).strftime(TimeTable::DATE_TIME_FORMAT)
      result += "\n"
    end

    result
  end

  def get_option(car, time_table)
    sort_schedule = Hash[ schedule.sort_by { |key, value| key } ]
    schedule = sort_schedule
    date_start = car.preferred_pick_up_date
    date_limit = car.schedule_date
    option = compute_option(date_start, date_limit, time_table)
    
    option
  end

  def compute_option(date_start, date_limit, time_table)
    future_date = find_future_date(date_start, time_table)
    
    future_date
  end

  def find_future_date(date_start, time_table)
    ###TODO REFACTOR!!!
    start_array = schedule.keys
    process_array = start_array.map{ |date| process(date) }

    return date_start.clone if start_array.empty? 
    
    best_possible_finish = process(date_start)
    if time_table.out_of_program(best_possible_finish)
      next_work_date = time_table.find_next_work_date(best_possible_finish)
    
      return find_future_date(next_work_date, time_table)  
    end
    
    final_process = final_schedule_from_day(time_table, date_start, start_array)
    empty_hours_end = (time_table.date_end_program(date_start) - final_process) / TimeTable::HOUR
    if (empty_hours_end >= process_hours)
      if (date_start > final_process)
        
        return date_start
      else 
        
        return final_process
      end

    end

  end

  def final_schedule_from_day(time_table, date_start, start_array)
    start_day_array = start_array.select { |date| date.strftime(TimeTable::DATE_FORMAT) == date_start.strftime(TimeTable::DATE_FORMAT) }
    process_day_array = start_day_array.map{ |date| process(date) }

    start_day_array.empty? ? time_table.date_start_program(date_start) : process_day_array.last
  end

  def process(date_start)
    date_finish = date_start + TimeTable::HOUR * process_hours
    
    date_finish
  end

end
