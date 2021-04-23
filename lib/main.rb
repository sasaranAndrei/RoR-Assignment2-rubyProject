require_relative 'cleaning_service'
require_relative 'station'
require_relative 'car'
require_relative 'time_table'
require 'date'
require 'time'

INPUT_FILE = "/data1.in"
INPUT_FOLDER = "input"
INPUT = INPUT_FOLDER + INPUT_FILE

def try_create_station(process_hours)
  begin
    station = Station.new(process_hours)
  rescue
    Exception
    puts Station::INVALID_INPUT_MESSAGE
  end

  station
end

def create_stations(station_count, process_hours)
  stations = []
  station_count.times do
    station = try_create_station(process_hours)
    stations.append(station) unless station.nil?
  end

  stations
end

def try_create_car(schedule_date, pick_up_date)
  begin
    car = Car.new(schedule_date, pick_up_date)
  rescue
    Exception
    puts Car::INVALID_INPUT_MESSAGE
  end

  car
end

def read_cars(file, car_count)
  cars = []
  car_count.times do
    schedule_date, pick_up_date = file.readline.split
    car = try_create_car(schedule_date, pick_up_date)
    cars.append(car) unless car.nil?
  end
  
  cars
end

def try_create_cleaning_service(stations, queue)
  begin
    cleaning_service = CleaningService.new(stations, queue)
  rescue
    Exception
    puts CleaningService::INVALID_INPUT_MESSAGE
  end

  cleaning_service
end

def read_input
  file = File.open(INPUT, "r")
  car_count, station_count, process_hours = file.readline.split.map(&:to_i)
  stations = create_stations(station_count, process_hours)
  queue = read_cars(file, car_count)
  cleaning_service = try_create_cleaning_service(stations, queue)
  file.close

  cleaning_service
end

def go
  cleaning_service = read_input
  puts cleaning_service
  puts "Work:"
  cleaning_service.work
  puts cleaning_service.info
end

def main2
  go
end

main2
