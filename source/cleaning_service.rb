# astia au mai multe statii de curatare
# un orar in care functioneaza => hash cu zilele saptamanii
# masinile programate
require_relative 'time_table'

class CleaningService
  # attr_accessor :station_count 
  # attr_accessor :car_count
  attr_accessor :time_table
  attr_accessor :stations
  attr_accessor :cars

  def initialize()
    # @stations = Array.new()
    # @cars = Array.new()
    @stations = nil
    @cars = nil
    @time_table = TimeTable.new
  end

  #def to_s
  #  "Cleaning Service : (stations = #{@stations}, cars = #{@cars})\n"
  #end

  def to_s
    result = "Cleaning Service\n"
    @stations.each {|station| result += station.to_s}
    result += "Queue:\n"
    @cars.each {|car| result += car.to_s}
    return result
  end

end