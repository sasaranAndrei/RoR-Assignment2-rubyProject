require 'main'

describe 'read_input' do
  
  let(:car1) { Car.new("19-04-2021_08:10") }
  let(:car2) { Car.new("19-04-2021_08:23", "20-04-2021_09:10") }
  let(:file_cars) { File.open("input/test_cars.in", "r") }
  let(:station) { Station.new(2) }

  it 'reads cars from file' do
    expected_array = [car1, car2, nil, nil]
    input_cars = read_cars(file_cars, 4)
    expect(input_cars[0].schedule_date).to eql(expected_array[0].schedule_date)
    expect(input_cars[0].preferred_pick_up_date).to eql(expected_array[0].preferred_pick_up_date)
    expect(input_cars[1].schedule_date).to eql(expected_array[1].schedule_date)
    expect(input_cars[1].preferred_pick_up_date).to eql(expected_array[1].preferred_pick_up_date)
    expect(input_cars[2]).to be expected_array[2]
    expect(input_cars[3]).to be expected_array[3]
    expect(input_cars[0].car_id).to be > 0
    expect(input_cars[0].car_id).to be < input_cars[1].car_id
  end

  it 'creates stations from file' do
    
    expected_array = [station, nil, nil]
    input_stations = []
    File.readlines("input/test_stations.in").each do |line|
      station_count, process_hours = line.split.map(&:to_i)
      stations = create_stations(station_count, process_hours)
      input_stations.append(stations[0])
    end
    expect(input_stations[0]).to have_attributes(:station_id => (a_value > 0),
                                                  :process_hours => expected_array[0].process_hours)
    expect(input_stations[1]).to be expected_array[1]
    expect(input_stations[2]).to be expected_array[2]
  end

end
