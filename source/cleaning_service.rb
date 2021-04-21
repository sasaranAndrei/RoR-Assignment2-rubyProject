# astia au mai multe statii de curatare
# un orar in care functioneaza => hash cu zilele saptamanii
# masinile programate
require_relative 'time_table'

class CleaningService
  # attr_accessor :station_count 
  # attr_accessor :car_count
  attr_accessor :time_table
  attr_accessor :stations
  attr_accessor :queue

  def initialize()
    @stations = nil
    @queue = nil
    @time_table = TimeTable.new
  end

  def to_s
    result = "Cleaning Service\n"
    stations.each {|station| result += station.to_s}
    result += "Queue:\n"
    queue.each {|car| result += car.to_s}
    return result
  end

  def info
    result = "Schedules:\n"
    stations.each {|station|
      result += "Station " + station.station_id.to_s + "\n"
      result += station.appointments
      result += "\n"
    }
    result
  end

  def work
    # queue.each {|car| schedule(car)} #delete from odd indexes:)))
    until queue.empty?
      car = queue.first
      schedule(car)
    end
  end
  
  def schedule(car)
    #puts car
    assigned_station, empty_spot = find_empty_spot(car)
    stations[assigned_station].schedule[empty_spot] = car
    queue.delete_at(0)
  end

  def find_empty_spot(car)
    preferred_pick_up_date = car.preferred_pick_up_date
    options = compute_options(car)
    #return 0, options[0]
    best_option = find_best_option(options)
    # puts "best option"
    # puts best_option[0], best_option[1]
    return best_option
  end

  def find_best_option(options)
    #puts "OPTIONS:"
    #options.each {|key, value| puts value.strftime(TimeTable::DATE_TIME_FORMAT), key}
    sorted_options = Hash[ options.sort_by { |key, value| value } ]
    
    #puts "SORTED OPTIONS:"
    #sorted_options.each {|key, value| puts value.strftime(TimeTable::DATE_TIME_FORMAT), key}
    
    return sorted_options.first  
  end

  def compute_options(car)
    options = Hash.new
    stations.each {|station| 
      option = station.get_option(car, time_table)  
      options[station.station_id] = option
    }
    return options
  end

end