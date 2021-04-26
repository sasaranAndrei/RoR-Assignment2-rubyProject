require 'station'
require 'car'

describe 'station' do

  let(:station) { Station.new(2) }
  let(:car) { Car.new("19-04-2021_18:10") }
  let(:car1) { Car.new("19-04-2021_08:10") }
  let(:car2) { Car.new("19-04-2021_08:25") }
  let(:time_table) { TimeTable.new }
  let(:date_monday) { Time.parse("19-04-2021_18:10") }
  let(:date_tuesday) { Time.parse("20-04-2021_07:45") }
  let(:date_friday) { Time.parse("23-04-2021_18:10") }

  it 'computes end of processing time for a car' do
    expect_date = Time.parse("19-04-2021_20:10")
    process_date = station.process(car.preferred_pick_up_date)
    expect(process_date).to eql expect_date
  end

  it 'computes best option for a car' do
    cars = [car1, car2]
    expect_dates = [Time.parse("19-04-2021_08:10"), 
                    Time.parse("19-04-2021_10:10")]
    option1 = station.get_option(car1, time_table)
    station.schedule[option1] = car1
    option2 = station.get_option(car2, time_table)
    option_dates = [option1, option2]
    2.times do |i|
      expect(option_dates[i]).to eql expect_dates[i]  
    end
  end

end
