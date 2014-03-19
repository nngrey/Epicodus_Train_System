require 'spec_helper'

describe Station do

  describe '#initialize' do
    it 'will initialize an instance of Station with a name' do
      test_station = Station.new({:name =>'Hawthorne'}) #{:name =>'Hawthorne'
      test_station.should be_an_instance_of Station
      test_station.name.should eq 'Hawthorne'
    end
  end
  describe '==' do
    it 'is the same station if it has the same name' do
      test_station1 = Station.new({:name =>'Hawthorne'})
      test_station2 = Station.new({:name =>'Hawthorne'})
      test_station1.should eq test_station2
    end
  end

  describe 'self.all' do
    it 'starts off with no stations' do
      Station.all.should eq []
    end
  end

  describe '#save' do
    it 'saves the station instances into the database' do
      test_station = Station.new({:name =>'Hawthorne'})
      test_station.save
      Station.all.should eq [test_station]
    end
  end

end
