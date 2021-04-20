require 'date'
require_relative 'time_table'
class Car
  attr_accessor :schedule_date, :pick_up_date, :car_id
  @@car_count = 0 
  # @@DEFAULT_DATE = Time.now.strftime("%d-%m-%Y")
  #DEFAULT_DATE = Date.parse("19-04-2021")
  # DEFAULT_DATE = "19-04-2021"

  def initialize(schedule_date, pick_up_date)
    # todo validate!
    @car_id = @@car_count
    @@car_count += 1
    @schedule_date = DateTime.parse(schedule_date)
    @pick_up_date = pick_up_date.nil? ? @schedule_date : DateTime.parse(pick_up_date)
  end

  def to_s
    "Car : (car_id = #{@car_id}, schedule_date = #{@schedule_date.strftime(TimeTable::DATE_TIME_FORMAT)}, pick_up_date = #{@pick_up_date.strftime(TimeTable::DATE_TIME_FORMAT)})\n"
  end

end