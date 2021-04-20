class Station

  attr_accessor :process_hours, :schedule, :station_id
  @@station_count = 0 

  def initialize(process_hours)
    @station_id = @@station_count
    @@station_count += 1

    @process_hours = process_hours
    @schedule = Hash.new
  end

  def to_s
    "Station : (station_id = #{station_id}, process_hours = #{@process_hours}, <schedule>)\n"
  end

  def get_option(car, time_table)
    # sort by key (date) 
    schedule = schedule.sort_by { |key| key }.to_h
    
    date_start = find_date_start(car.preferred_pick_up_date)# - 2hours
    date_limit = find_date_limit(car.schedule_date)

    #until 
    compute_option(date_start, date_limit)

    return nil
  end

  def compute_option(date_start, date_limit)
    date = date_start
    #until date > date_limit

    #end
  end


end