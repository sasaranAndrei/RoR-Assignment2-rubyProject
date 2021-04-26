require_relative 'time_table'

class CleaningService
  INVALID_INPUT_MESSAGE = "\nInvalid Cleaning Service Input!\nPlease provide valid input for Stations and Cars\n\n"

  attr_accessor :time_table, :stations, :queue

  def initialize(stations, queue)
    raise if invalid_input(stations, queue)
    
    @stations = stations
    @queue = queue
    @time_table = TimeTable.new
  end

  def invalid_input(stations, queue)
    stations.nil? || queue.nil?
  end

  def to_s
    result = "Cleaning Service\n"
    stations.each { |station| result += station.to_s }
    result += "Queue:\n"
    queue.each { |car| result += car.to_s }
    
    result
  end

  def info
    result = "Schedules:\n"
    stations.each do |station|
      result += "Station " + station.station_id.to_s + "\n"
      result += station.appointments
      result += "\n"
    end

    result
  end

  def work
    until queue.empty?
      schedule(queue.first) unless stations.empty?
      queue.delete_at(0)
    end 
  end
  
  def schedule(car)
    assigned_station, empty_spot = find_empty_spot(car)
    stations[assigned_station].schedule[empty_spot] = car
  end

  def find_empty_spot(car)
    options = compute_options(car)
    best_option = find_best_option(options)
    
    best_option
  end

  def find_best_option(options)
    sorted_options = Hash[ options.sort_by { |key, value| value } ]
    
    sorted_options.first  
  end

  def compute_options(car)
    options = Hash.new
    stations.each do |station| 
      option = station.get_option(car, time_table)  
      options[station.station_id] = option
    end
    
    options
  end

end
