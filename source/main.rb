require_relative 'cleaning_service'
require_relative 'station'
require_relative 'car'
require_relative 'time_table'
require 'date'
require 'time'

INPUT_FILE = "/data2.in"
INPUT_FOLDER = "../input"
INPUT = INPUT_FOLDER + INPUT_FILE

def create_stations(station_count, process_hours)
  stations = []
  station_count.times {
    station = Station.new(process_hours)
    stations.append(station)
  }
  return stations
end

def read_cars(file, car_count)
  cars = []
  car_count.times {
    schedule_date, pick_up_date = file.readline.split
    car = Car.new(schedule_date, pick_up_date)
    cars.append(car)
  }
  return cars
end

def read_input
  file = File.open(INPUT, "r")
  car_count, station_count, process_hours = file.readline.split.map(&:to_i)
  
  cleaning_service = CleaningService.new()
  cleaning_service.stations = create_stations(station_count, process_hours)
  cleaning_service.queue = read_cars(file, car_count)

  file.close
  return cleaning_service
end

def go
  cleaning_service = read_input
  #puts "what" if cleaning_service.stations[0].nil?
  puts cleaning_service
  puts "Work:"
  cleaning_service.work
  
  puts cleaning_service.info
end

def main
  go
  #### TESTING STUFF.
  # date = Time.parse("16-04-2021_17:00")
  # date_string = date
  # time_string = date.

  # new_date_string = date_string + "_" + time_string
  # new_date = Time.parse(new_date_string)
  # puts date_string, time_string
  # puts date
  # puts new_date


  # array = [1, 2, 3]
  # puts array.last


  # hash = Hash.new
  # puts hash.values.nil?.to_s

  # testing stuff...

  # tt = TimeTable.new
  # date = Time.parse("16-04-2021_17:00")
  # station = Station.new(2)
  # puts station.process(date).strftime(TimeTable::DATE_TIME_FORMAT)
  # # time = date.strftime(TimeTable::TIME_FORMAT)
  # # puts time
  # time = Time.parse("14-04-2021_09:00")

  # finish = time + 2 * 60 * 60
  # puts date.strftime(TimeTable::DATE_TIME_FORMAT)
  # puts finish.strftime(TimeTable::DATE_TIME_FORMAT)

  # puts date.class
  # puts finish.class

  # puts (time_obj + 2 * 60 * 60).strftime(TimeTable::DATE_TIME_FORMAT)
  
  
  # date_plus = date 
  # puts date.strftime(TimeTable::DATE_TIME_FORMAT)
  # puts "Out of program: " + tt.out_of_program(date).to_s
  # puts "Next work date: " + tt.find_next_work_date(date).strftime(TimeTable::DATE_TIME_FORMAT) if tt.out_of_program(date)


  # time_table = TimeTable.new
  # schedule = Hash.new
  # cleaning_service = read_input

  # car1 = Car.new("19-04-2021_10:00", nil)
  # car2 = Car.new("19-04-2021_15:00", nil)

  # data1 = car1.schedule_date
  # data2 = car2.schedule_date

  # schedule[data2] = car2
  # schedule[data1] = car1


  # schedule.each {|key, val| puts key.strftime(TimeTable::DATE_TIME_FORMAT), val}

  # puts 

  # sort_schedule = Hash[ schedule.sort_by { |key, val| key } ]
  # #  = schedule.sort_by { |key| key }.to_h
  # schedule = sort_schedule
  # # schedule = schedule.sort_by { |key| key }.to_h
  # # sort_schedule = sc
  # schedule.each {|key, val| puts key.strftime(TimeTable::DATE_TIME_FORMAT), val}

  # puts schedule.first[0].strftime(TimeTable::DATE_TIME_FORMAT)
  # puts schedule.first[1]

  # start_array = schedule.keys
  # process_array = start_array.map{|x| process(x)}#(&:process)
  
  # puts start_array
  # puts process_array
  
  # date_start = car1.schedule_date
  # process_hours = 2


  # final_process = process_array.last
  # puts time_table.date_end_program(date_start), final_process
  # empty_hours_end = (time_table.date_end_program(date_start) - final_process) / TimeTable::HOUR
  # puts empty_hours_end
  # if (empty_hours_end >= process_hours)
  #   return final_process
  # end

  # list = [1, 2, 3]
  # print list
  # puts

  # list.append(4)
  # print list
  # puts

  # list.delete(1)
  # list.delete(2)
  # list.delete(3)
  # list.delete(4)
  # print "hopa" if list.nil?
  # print list
  # puts
end

main