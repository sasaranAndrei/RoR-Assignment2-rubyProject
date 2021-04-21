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
    # a = Hash[ schedule.sort_by { |key, val| key } ]
    schedule.sort_by { |key| key }.to_h
    
    date_start = find_date_start(car.preferred_pick_up_date)
    date_limit = find_date_limit(car.schedule_date)

    #until 
    compute_option(date_start, date_limit)

    return nil
  end

  def compute_option(date_start, date_limit)
    past_date = find_past_date(date_start, date_limit)
    future_date = find_future_date(date_start)
    return past_date.nil? ? future_date : past_date
  end

  def find_future_date(date_start)
    date_finish = process(date_start)
    nil
    # schedule.each {|key, val|}
  end

  def process(date_start)
    nil
  end

  def find_past_date(date_start, date_limit)
    nil
    date = date_start # - 2 hours
    # until date < date_limit
    #   nil
    # end
  end

  def find_date_start(date)
    nil
  end

  def find_date_limit(date)
    nil
  end

end