class Station

  attr_accessor :process_hours, :schedule

  def initialize(process_hours)
    @process_hours = process_hours
    @schedule = Hash.new
  end

  def to_s
    "Station : (process_hours = #{@process_hours}, <schedule>)\n"
  end

end