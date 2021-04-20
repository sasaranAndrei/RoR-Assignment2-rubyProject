require 'date'
class TimeTable

  DATE_TIME_FORMAT = "%d/%m/%Y_%H:%M"
  TIME_FORMAT = "%H:%M"
  DEFAULT_DATE = DateTime.parse("19-04-2021")
  DEFAULT_START_PROGRAM = {
    :Monday => DateTime.parse("1-1-1_08:00"),
    :Tuesday => DateTime.parse("1-1-1_08:00"),
    :Wednesday => DateTime.parse("1-1-1_08:00"),
    :Thursday => DateTime.parse("1-1-1_08:00"),
    :Friday => DateTime.parse("1-1-1_08:00")
  }
  DEFAULT_END_PROGRAM = {
    :Monday => DateTime.parse("1-1-1_20:00"),
    :Tuesday => DateTime.parse("1-1-1_20:00"),
    :Wednesday => DateTime.parse("1-1-1_20:00"),
    :Thursday => DateTime.parse("1-1-1_20:00"),
    :Friday => DateTime.parse("1-1-1_16:00")
  }

  attr_accessor :start_program, :end_program


  def initialize()
    @start_program = DEFAULT_START_PROGRAM
    @end_program = DEFAULT_END_PROGRAM
  end


    
end