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
    (row_index / 3) + ((column_index / 3) * 3)
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
        cell.check_row(@board) if cell.value.nil?
        cell.check_column(@board) if cell.value.nil?
        cell.check_box(@board) if cell.value.nil?
      end
    end
    board_state
  end

  def board_state
    all_values = []
    @board.each do |cell|
      value = cell.value ? cell.value : '.'
      all_values << value
    end
    board_state = all_values.each_slice(9).to_a
    board_state.map! do |row|
      row.join('')
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

  def check_row(board)
    @value = @possibilities[0] if @value.nil? && @possibilities.count == 1
    return unless @value.nil?
    board_row = board.select { |c| c.row == @row }
    board_row.each do |c|
      next if c.value.nil?
      next unless value.nil?
      poss = @possibilities.dup
      binding.pry if poss.delete_if { |p| p == c.value }.empty?
      @possibilities.delete_if { |p| p == c.value }
      @value = @possibilities[0] if @possibilities.count == 1
    end
  end

  def check_column(board)
    return unless @value.nil?
    board_column = board.select { |c| c.column == @column }
    board_column.each do |c|
      next if c.value.nil?
      @value = @possibilities[0] if @possibilities.count == 1
      next unless @value.nil?
      poss = @possibilities.dup
      binding.pry if poss.delete_if { |p| p == c.value }.empty?
      @possibilities.delete_if { |p| p == c.value }
    end
  end

  def check_box(board)
    return unless @value.nil?
    board_box = board.select { |c| c.box == @box }
    binding.pry
    board_box.each do |c|
      next if c.value.nil?
      @value = @possibilities[0] if @possibilities.count == 1
      next unless @value.nil?
      poss = @possibilities.dup
      binding.pry if poss.delete_if { |p| p == c.value }.empty?
      @possibilities.delete_if { |p| p == c.value }
    end
  end
end

puts "Easy Puzzle 1:"
solver = Solver.new
solver.generate_cells_from_puzzle('puzzles/easy_01.txt')
puts "#{solver.cells_unsolved.count} initially unsolved"
puts solver.board_state
solver.solve
if solver.solved?
  puts "Solved!"
else
  puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
end
puts ''
puts solver.board_state

# puts "Easy Puzzle 2:"
# solver = Solver.new
# solver.generate_cells_from_puzzle('puzzles/easy_02.txt')
# puts "#{solver.cells_unsolved.count} initially unsolved"
# solver.solve
# if solver.solved?
#   puts "Solved!"
# else
#   puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
# end
# puts ''

# puts "Easy Puzzle 3:"
# solver = Solver.new
# solver.generate_cells_from_puzzle('puzzles/easy_03.txt')
# puts "#{solver.cells_unsolved.count} initially unsolved"
# solver.solve
# if solver.solved?
#   puts "Solved!"
# else
#   puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
# end
# puts ''

# puts "Easy Puzzle 4:"
# solver = Solver.new
# solver.generate_cells_from_puzzle('puzzles/easy_04.txt')
# puts "#{solver.cells_unsolved.count} initially unsolved"
# solver.solve
# if solver.solved?
#   puts "Solved!"
# else
#   puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
# end
# puts ''

# puts "Medium Puzzle 1:"
# solver = Solver.new
# solver.generate_cells_from_puzzle('puzzles/medium_01.txt')
# puts "#{solver.cells_unsolved.count} initially unsolved"
# solver.solve
# if solver.solved?
#   puts "Solved!"
# else
#   puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
# end
# puts ''

# puts "Medium Puzzle 2:"
# solver = Solver.new
# solver.generate_cells_from_puzzle('puzzles/medium_02.txt')
# puts "#{solver.cells_unsolved.count} initially unsolved"
# solver.solve
# if solver.solved?
#   puts "Solved!"
# else
#   puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
# end
# puts ''

# puts "Medium Puzzle 3:"
# solver = Solver.new
# solver.generate_cells_from_puzzle('puzzles/medium_03.txt')
# puts "#{solver.cells_unsolved.count} initially unsolved"
# solver.solve
# if solver.solved?
#   puts "Solved!"
# else
#   puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
# end
# puts ''

# puts "Hard Puzzle 1:"
# solver = Solver.new
# solver.generate_cells_from_puzzle('puzzles/hard_01.txt')
# puts "#{solver.cells_unsolved.count} initially unsolved"
# solver.solve
# if solver.solved?
#   puts "Solved!"
# else
#   puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
# end
# puts ''

# puts "Hard Puzzle 2:"
# solver = Solver.new
# solver.generate_cells_from_puzzle('puzzles/hard_02.txt')
# puts "#{solver.cells_unsolved.count} initially unsolved"
# solver.solve
# if solver.solved?
#   puts "Solved!"
# else
#   puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
# end
# puts ''

# puts "Evil Puzzle 1:"
# solver = Solver.new
# solver.generate_cells_from_puzzle('puzzles/evil_01.txt')
# puts "#{solver.cells_unsolved.count} initially unsolved"
# solver.solve
# if solver.solved?
#   puts "Solved!"
# else
#   puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
# end
# puts ''

# puts "Evil Puzzle 2:"
# solver = Solver.new
# solver.generate_cells_from_puzzle('puzzles/evil_02.txt')
# puts "#{solver.cells_unsolved.count} initially unsolved"
# solver.solve
# if solver.solved?
#   puts "Solved!"
# else
#   puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
# end
# puts ''

# puts "Evil Puzzle 3:"
# solver = Solver.new
# solver.generate_cells_from_puzzle('puzzles/evil_03.txt')
# puts "#{solver.cells_unsolved.count} initially unsolved"
# solver.solve
# if solver.solved?
#   puts "Solved!"
# else
#   puts "Not solved: #{solver.cells_unsolved.count} remaining unsolved"
# end
# puts ''

