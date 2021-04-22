require_relative 'cleaning_service'
require_relative 'station'
require_relative 'car'
require_relative 'time_table'
require 'date'
require 'time'

INPUT_FILE = "/data1.in"
INPUT_FOLDER = "../input"
INPUT = INPUT_FOLDER + INPUT_FILE

def create_stations(station_count, process_hours)
  stations = []
  station_count.times do
    station = Station.new(process_hours)
    stations.append(station)
  end

  stations
end

def read_cars(file, car_count)
  cars = []
  car_count.times do
    schedule_date, pick_up_date = file.readline.split
    car = Car.new(schedule_date, pick_up_date)
    cars.append(car)
  end
  
  cars
end

def read_input
  file = File.open(INPUT, "r")
  car_count, station_count, process_hours = file.readline.split.map(&:to_i)
  cleaning_service = CleaningService.new
  cleaning_service.stations = create_stations(station_count, process_hours)
  cleaning_service.queue = read_cars(file, car_count)
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

def main
  go
end

main
