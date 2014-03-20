require 'spec_helper'

describe Line do
  describe '#initialize' do
    it 'initializes an instance of the class with a name' do
      test_line = Line.new({:number => 23})
      test_line.should be_an_instance_of Line
      test_line.number.should eq 23
    end
  end

  describe '==' do
    it 'makes instances with the same number the same' do
      test_line1 = Line.new({:number => 23})
      test_line2 = Line.new({:number => 23})
      test_line1.should eq test_line2
    end
  end

  describe 'self.all' do
    it 'starts off with no lines' do
      Line.all.should eq []
    end
  end

  describe '#save' do
    it 'saves an instance of the class to an array of all instances' do
      test_line = Line.new({:number => 3})
      test_line.save
      Line.all.should eq [test_line]
    end
  end
end
