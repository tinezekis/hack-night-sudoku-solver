require 'pry'

class Solver
  attr_accessor :board

  def initialize
    @board = []
  end

  def generate_cells_from_puzzle(file)
    possibilities = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
    puzzle = File.open(file).each_with_index do |line, row_index|
      row = line.split('')
      row.delete_if { |character| character == "\n"}
      row.each_with_index do |value, column_index|
        box_index = box_assigner(row_index, column_index)
        if row[column_index] == '.'
          @board << Cell.new(
            value:         nil,
            possibilities: possibilities,
            row:           row_index,
            column:        column_index,
            box:           box_index
          )
        else
          @board << Cell.new(
            value:         value,
            possibilities: [value],
            row:           row_index,
            column:        column_index,
            box:           box_index
          )
        end
      end
    end
  end

  def box_assigner(row_index, column_index)
    box_index = nil
    if (0..2).include?(row_index)
      if (0..2).include?(column_index)
        box_index = 0
      elsif (3..5).include?(column_index)
        box_index = 1
      else
        box_index = 2
      end
    elsif (3..5).include?(row_index)
      if (0..2).include?(column_index)
        box_index = 3
      elsif (3..5).include?(column_index)
        box_index = 4
      else
        box_index = 5
      end
    else
      if (0..2).include?(column_index)
        box_index = 6
      elsif (3..5).include?(column_index)
        box_index = 7
      else
        box_index = 8
      end
    end
    box_index
  end

  def cells_unsolved
    @board.select { |cell| cell.value.nil? }
  end

  def solved?
    cells_unsolved.empty?
  end

  def solve
    while !solved?
      @board.each do |cell|
        Cell.check_row(cell, @board) if cell.value.nil?
        Cell.check_column(cell, @board) if cell.value.nil?
        Cell.check_box(cell, @board) if cell.value.nil?
      end
    end
  end
end

class Cell
  attr_reader :row, :column, :box
  attr_accessor :value, :possibilities

  def initialize(**args)
    @value = args[:value]
    @possibilities = args[:possibilities]
    @row = args[:row]
    @column = args[:column]
    @box = args[:box]
  end

  def to_s
    "Cell
* value: #{value}
* possibilities: #{possibilities}
* row: #{row}
* column: #{column}
* box: #{box}\n\n"
  end

  def self.check_row(cell, board)
    return unless cell.value.nil?
    row = board.select { |c| c.row == cell.row }
    row.each do |c|
      next if c.value.nil?
      cell.value = cell.possibilities[0] if cell.possibilities.count == 1
      next unless cell.value.nil?
      poss = cell.possibilities.dup
      binding.pry if poss.delete_if { |p| p == c.value }.empty?
      cell.possibilities.delete_if { |p| p == c.value }
    end
  end

  def self.check_column(cell, board)
    return unless cell.value.nil?
    column = board.select { |c| c.column == cell.column }
    column.each do |c|
      next if c.value.nil?
      cell.value = cell.possibilities[0] if cell.possibilities.count == 1
      next unless cell.value.nil?
      poss = cell.possibilities.dup
      binding.pry if poss.delete_if { |p| p == c.value }.empty?
      cell.possibilities.delete_if { |p| p == c.value }
    end
  end

  def self.check_box(cell, board)
    return unless cell.value.nil?
    box = board.select { |c| c.box == cell.box }
    box.each do |c|
      next if c.value.nil?
      cell.value = cell.possibilities[0] if cell.possibilities.count == 1
      next unless cell.value.nil?
      poss = cell.possibilities.dup
      binding.pry if poss.delete_if { |p| p == c.value }.empty?
      cell.possibilities.delete_if { |p| p == c.value }
    end
  end
end

puts "Easy Puzzle 1:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/easy_01.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''

puts "Easy Puzzle 2:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/easy_02.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''

puts "Easy Puzzle 3:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/easy_03.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''

puts "Easy Puzzle 4:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/easy_04.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''

puts "Medium Puzzle 1:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/medium_01.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''

puts "Medium Puzzle 2:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/medium_02.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''

puts "Medium Puzzle 3:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/medium_03.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''

puts "Hard Puzzle 1:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/hard_01.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''

puts "Hard Puzzle 2:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/hard_02.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''

puts "Evil Puzzle 1:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/evil_01.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''

puts "Evil Puzzle 2:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/evil_02.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''

puts "Evil Puzzle 3:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/evil_03.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''

