require 'date'
require 'time'
require_relative 'time_table'

class Car
  attr_accessor :schedule_date, :preferred_pick_up_date, :car_id
  @@car_count = 0 

  def initialize(schedule_date, preferred_pick_up_date)
    # todo validate!
    @car_id = @@car_count
    @@car_count += 1
    @schedule_date = Time.parse(schedule_date)
    @preferred_pick_up_date = preferred_pick_up_date.nil? ? @schedule_date : Time.parse(preferred_pick_up_date)
  end

  def to_s
    result = "Car : (car_id = #{ car_id }, schedule_date = #{ schedule_date.strftime(TimeTable::DATE_TIME_FORMAT) }" 
    pick_up_message = preferred_pick_up_date.nil? ? ")\n" : ", preferred_pick_up_date = #{ preferred_pick_up_date.strftime(TimeTable::DATE_TIME_FORMAT) })\n" 
    result += pick_up_message
    
    result
  end

end
