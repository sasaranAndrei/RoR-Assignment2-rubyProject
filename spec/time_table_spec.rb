require 'time_table'

describe 'time_table' do
  
  let(:time_table) { TimeTable.new }
  let(:date_monday) { Time.parse("19-04-2021_18:10") }
  let(:date_tuesday) { Time.parse("20-04-2021_07:45") }
  let(:date_friday) { Time.parse("23-04-2021_18:10") }

  it 'finds day of week' do
    expect_monday = time_table.find_day_of_week(date_monday)
    expect_friday = time_table.find_day_of_week(date_friday)
    expect(expect_monday).to be :Monday
    expect(expect_friday).to be :Friday
  end

  it 'checks invalid program' do
    monday_out_of_program = time_table.out_of_program(date_monday)
    friday_out_of_program = time_table.out_of_program(date_friday)
    expect(monday_out_of_program).to be false
    expect(friday_out_of_program).to be true
  end

  it 'finds next working date' do
    tuesday_next_work_date = time_table.find_next_work_date(date_tuesday)
    friday_next_work_date = time_table.find_next_work_date(date_friday)
    expect_tuesday = Time.parse("20-04-2021_08:00")
    expect_friday = Time.parse("26-04-2021_08:00")
    expect(tuesday_next_work_date).to eql expect_tuesday
    expect(friday_next_work_date).to eql expect_friday
  end

end
