require 'pg'
require './lib/line'
require './lib/station'

DB = PG.connect({:dbname => 'train_system'})

def welcome
  puts "\nTara - Off the Rails"
  puts "--------------------\n"
  main_menu
end

def main_menu
  puts "Select 's' to add a station"
  puts "Select 'l' to add a line"
  puts "Select 'c' to connect a line and a station"
  puts "Select 'v' to view the stations on a line"
  puts "Select 'r' to view lines"
  puts "Select 'x' to exit the program"
  user_input = gets.chomp
  case user_input
    when 's' then add_station
    when 'l' then add_line
    when 'c' then connect
    when 'v' then view_stations
    when 'r' then view_lines
    when 'x' then puts "Goodbye"
  else
    main_menu
  end
end

def add_station
  system('clear')
  puts "What is the station name you would like to add?"
  user_station = gets.chomp
  new_station = Station.new(:name => user_station)
  new_station.save
  puts "\nYou have entered '#{new_station.name}'! \n\n"
  main_menu
end

def add_line
  system('clear')
  puts "What is the line number you would like to add?"
  user_line = gets.chomp
  new_line = Line.new(:number => user_line)
  new_line.save
  puts "\nYou have entered '#{new_line.number}'! \n\n"
  main_menu
end

def connect
  puts "\nEnter the number of the station you would like to connect\n\n"
  Station.all.each_with_index do |station, index|
    puts "#{index + 1}. #{station.name}"
  end
  station_choice = (gets.chomp.to_i - 1)
  station_choice = Station.all[station_choice - 1].name
  station_choice = DB.exec("SELECT * FROM stations WHERE name = '#{station_choice}';")[0]['id']

  puts "\nEnter the number of the line you would like to connect\n"
  Line.all.each_with_index do |line, index|
    puts "#{line.number}"
  end
  line_choice = gets.chomp.to_i
  line_choice = DB.exec("SELECT * FROM lines WHERE number = #{line_choice};")[0]['id']

  join_id = DB.exec("INSERT INTO stops (line_id, station_id) VALUES ('#{line_choice}', '#{station_choice}') RETURNING id;")[0]['id']
  station_id = DB.exec("SELECT * FROM stops WHERE id = #{join_id};")[0]['station_id']
  line_id = DB.exec("SELECT * FROM stops WHERE id = #{join_id};")[0]['line_id']
  station = DB.exec("SELECT * FROM stations WHERE id = #{station_id};")[0]['name']
  line = DB.exec("SELECT * FROM lines WHERE id = #{line_id};")[0]['number']
  puts "\nYou have connected #{station} station with #{line} line.\n\n"
  main_menu
end
welcome









