require 'rubygems'
require 'sinatra'
require 'time'
require 'tzinfo'

#used array instead of hash because I need them in order
$schedule = [
  ['1st',  Time.parse("8:00 am").utc], 
  ['2nd',  Time.parse("8:55 am").utc],
  ['3rd',  Time.parse("9:50 am").utc],
  ['4th',  Time.parse("10:45 am").utc],
  ['5th',  Time.parse("11:45 am").utc],
  ['6th',  Time.parse("12:35 pm").utc],
  ['7th',  Time.parse("1:30 pm").utc],
  ['8th',  Time.parse("2:25 pm").utc],
  ['9th',  Time.parse("3:20 pm").utc],
  ['10th', Time.parse("4:15 pm").utc]
]


helpers do
  def get_time(period)
    return period[1]
  end

  def current_time
    to_local(Time.now.utc)
  end

  def to_local(time)
    tz = TZInfo::Timezone.get('America/Indiana/Indianapolis')
    tz.utc_to_local(time)
  end

  def current_period
    $schedule.each do |period|
      if to_local(get_time(period)) <=> current_time
        current = period
      end
    end

    if defined? current
      return current
    else
      return $schedule[0]
    end
  end
end

get '/' do
  puts "The next period is #{to_local(current_period[1])} - #{current_period[1]}"
  difference = to_local(current_period[1]) - current_time
  seconds = difference % 60
  difference = (difference - seconds) / 60
  minutes = difference % 60
  difference = (difference - minutes) / 60
  hours = difference % 24

  "#{hours.to_i}:#{minutes.to_i} until #{current_period[0]} hour"
end
