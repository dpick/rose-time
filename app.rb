require 'rubygems'
require 'sinatra'
require 'time'

#used array instead of hash because I need them in order
configure do
  SCHEDULE = [
    ['1st',  Time.parse("8:00 am")], 
    ['2nd',  Time.parse("8:55 am")],
    ['3rd',  Time.parse("9:50 am")],
    ['4th',  Time.parse("10:45 am")],
    ['5th',  Time.parse("11:45 am")],
    ['6th',  Time.parse("12:35 pm")],
    ['7th',  Time.parse("1:30 pm")],
    ['8th',  Time.parse("2:25 pm")],
    ['9th',  Time.parse("3:20 pm")],
    ['10th', Time.parse("4:15 pm")]
  ]
end

helpers do
  def get_time(period)
    return period[1]
  end

  def current_period
    current = SCHEDULE[0]

    SCHEDULE.each do |period|
      if get_time(period) <=> Time.now
        current = period
      end
    end

    return current
  end
end

#puts "The next period is #{current_period[0]}"
get '/' do
  difference = current_period[1] - Time.now
  seconds = difference % 60
  difference = (difference - seconds) / 60
  minutes = difference % 60
  difference = (difference - minutes) / 60
  hours = difference % 24

  "#{hours.to_i}:#{minutes.to_i} until #{current_period[0]}"
end
