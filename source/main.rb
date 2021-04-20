require_relative 'cleaning_service'
require_relative 'station'
require_relative 'car'
require_relative 'time_table'
require 'date'

INPUT_FILE = "/data1.in"
INPUT_FOLDER = "../input"
INPUT = INPUT_FOLDER + INPUT_FILE

def test
  #data = DateTime.now
  data = DateTime.new(2021,4,19,0,2)
  myData = DateTime.parse("2021-04-19T08:03:00+00:00")
  
  string = "19/04/2021_00:01"

  parseData = DateTime.parse(string)

  data1 = data.strftime(TimeTable::DATE_TIME_FORMAT)
  data2 = parseData.strftime(TimeTable::DATE_TIME_FORMAT)

  time1 = DateTime.new(1,1,1,8,3).strftime(TimeTable::TIME_FORMAT)
  time2 = DateTime.parse("1/1/1_17:02").strftime(TimeTable::TIME_FORMAT)

  puts data1
  puts data2
  puts time1
  puts time2

end

def test1
  # tt = TimeTable.new
  date = TimeTable::DEFAULT_DATE
  puts date
end 

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
  cleaning_service.cars = read_cars(file, car_count)

  file.close
  return cleaning_service
end

def main
  #test1
  # test
  cleaning_service = read_input
  puts cleaning_service
  
  #cleaning_service.work
  time_table = cleaning_service.time_table

  puts data = cleaning_service.cars[0].schedule_date
  time1 =  data.strftime(TimeTable::TIME_FORMAT)

  time_start = time_table.start_program[:Monday].strftime(TimeTable::TIME_FORMAT)
  time_end = time_table.end_program[:Monday].strftime(TimeTable::TIME_FORMAT)
  
  puts time_start, time_end
  puts time_start < time_end

end

main