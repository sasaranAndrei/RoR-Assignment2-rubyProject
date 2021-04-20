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
    # @stations = Array.new()
    # @queue = Array.new()
    @stations = nil
    @queue = nil
    @time_table = TimeTable.new
  end

  #def to_s
  #  "Cleaning Service : (stations = #{@stations}, queue = #{@queue})\n"
  #end

  def to_s
    result = "Cleaning Service\n"
    @stations.each {|station| result += station.to_s}
    result += "Queue:\n"
    @queue.each {|car| result += car.to_s}
    return result
  end

  def work
    # queue.each {|car| schedule(car)} #delete from odd indexes:)))
    until queue.empty?
      car = queue.first
      schedule(car)
    end
  end
  
  def schedule(car)
    puts car
    #queue.delete(car)
    
    assigned_station, empty_spot = find_empty_spot(car)
    #newSlot = createSlot(car) if emptySpot.nil?
  
    queue.delete_at(0)
  end

  def find_empty_spot(car)
    preferred_pick_up_date = car.preferred_pick_up_date
    options = compute_options(car)
    #best_option = find_best_option(options)
    #puts options
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