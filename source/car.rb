require 'date'
require 'time'
require_relative 'time_table'

class Car
  INVALID_INPUT_MESSAGE = "\nInvalid Car Input!\nPlease provide a schedule date (and optionally a preferred pick up date) with format: DD-MM-YYYY_HH_MM\nExample: 19-04-2021_14:39\n\n"
  
  attr_accessor :schedule_date, :preferred_pick_up_date, :car_id
  @@car_count = 0 

  def initialize(schedule_date, preferred_pick_up_date=nil)
    raise if invalid_input(schedule_date, preferred_pick_up_date)
    
    @car_id = @@car_count
    @@car_count += 1
    @schedule_date = Time.parse(schedule_date) # should I use Time.strptime(schedule_date, TimeTable::DATE_TIME_FORMAT) ?
    @preferred_pick_up_date = preferred_pick_up_date.nil? ? @schedule_date : Time.parse(preferred_pick_up_date)
  end

  def invalid_input(schedule_date, preferred_pick_up_date)
    begin
      parse_schedule_date = Time.parse(schedule_date)
    rescue
      ArgumentError
      return true if parse_schedule_date.nil?
    end

    false
  end

  def to_s
    result = "Car : (car_id = #{ car_id }, schedule_date = #{ schedule_date.strftime(TimeTable::DATE_TIME_FORMAT) }" 
    pick_up_message = preferred_pick_up_date.nil? ? ")\n" : ", preferred_pick_up_date = #{ preferred_pick_up_date.strftime(TimeTable::DATE_TIME_FORMAT) })\n" 
    result += pick_up_message
    
    result
  end

end
