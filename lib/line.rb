require 'pg'

class Line

attr_reader :number, :id

  def initialize(attributes)
    @number = attributes[:number]
    @id = attributes[:id]
  end

  def ==(another_line)
    self.number == another_line.number
  end

  def self.all
    results = DB.exec("SELECT * FROM lines;")
    lines = []
    results.each do |result|
      number = result['number'].to_i
      lines << Line.new({:number => number})
    end
    lines
  end

  def save
    DB.exec("INSERT INTO lines (number) VALUES ('#{@number}');")
  end

end
