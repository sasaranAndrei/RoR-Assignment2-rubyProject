require_relative 'time_table'
class Station

  attr_accessor :process_hours, :schedule, :station_id
  @@station_count = 0 

  def initialize(process_hours)
    @station_id = @@station_count
    @@station_count += 1
    @process_hours = process_hours
    @schedule = Hash.new
  end

  def to_s
    result = "Station : (station_id = #{station_id}, process_hours = #{process_hours}, schedule:\n)\n"
    schedule.each {|key, value| result += key.to_s + " -> " + value.to_s + "\n"}
    return result
  end

  def appointments
    result = ""
    schedule.each {|date, car|
      result += "Car#" + car.car_id.to_s
      result += " was schedule on " + car.schedule_date.strftime(TimeTable::DATE_TIME_FORMAT)
      result += ". Pick-up Date: " + process(date).strftime(TimeTable::DATE_TIME_FORMAT)
      result += "\n"
    }
    return result
  end

  def get_option(car, time_table)
    # sort by key (date) 
    sort_schedule = Hash[ schedule.sort_by { |key, value| key } ]
    schedule = sort_schedule

    date_start = car.preferred_pick_up_date
    date_limit = car.schedule_date
    option = compute_option(date_start, date_limit, time_table)
    return option
  end

  def compute_option(date_start, date_limit, time_table)
    past_date = find_past_date(date_start, date_limit, time_table)
    future_date = find_future_date(date_start, time_table)
    #return past_date.nil? ? future_date : past_date
    return future_date
  end

  def find_future_date(date_start, time_table)
    ###TODO REFACTOR!!!
    # puts "Station id " + station_id.to_s
    # date_finish = process(date_start)
    start_array = schedule.keys
    process_array = start_array.map{|date| process(date)}#(&:process)

    return date_start.clone if start_array.empty? 
    
    best_possible_finish = process(date_start)

    if time_table.out_of_program(best_possible_finish)
      next_work_date = time_table.find_next_work_date(best_possible_finish)
      # puts next_work_date.strftime(TimeTable::DATE_TIME_FORMAT)
      # puts "recursiv"
      return find_future_date(next_work_date, time_table)  
    end
    
    
    #process_array.each {|x| puts x}
    "
    start_array.each_with_index { |date, i|
      if (date > date_start)
        prev_date = start_array[i]
        process_prev = process_array[i]
        empty_hours = (date - prev_date) / TimeTable::HOUR
        if (empty_hours >= process_hours) 
          puts prev_date.strftime(TimeTable::DATE_TIME_FORMAT)
          puts time_table.date_end_program(date_start).strftime(TimeTable::DATE_TIME_FORMAT)
          puts empty_hours
          return process_prev
        end
      end

    }
    "
    # incercam la finalul prgramului
    final_process = process_array.last
    empty_hours_end = (time_table.date_end_program(date_start) - final_process) / TimeTable::HOUR
    if (empty_hours_end >= process_hours)
      # puts "return final_process"
      # puts final_process.strftime(TimeTable::DATE_TIME_FORMAT)
      # puts time_table.date_end_program(date_start).strftime(TimeTable::DATE_TIME_FORMAT)
      # puts empty_hours_end
      if (date_start > final_process)
        return date_start
      else 
        return final_process
      end
    end
    
  end

  def process(date_start)
    date_finish = date_start + TimeTable::HOUR * process_hours
    date_finish
  end

  def find_past_date(date_start, date_limit, time_table)
    nil
    #date = date_start # - 2 hours
    # until date < date_limit
    #   nil
    # end
  end

  def find_date_start(date)
    
  end

  def find_date_limit(date)
    nil
  end

end