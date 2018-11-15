require_relative '../solver'
describe 'Solver' do
  it 'solves the 1st easy puzzle' do
  	ez1 = "../puzzles/easy_01.txt"
  	solver = Solver.new(ez1)
  	solver.solve

  	expected_solution = ["325618497",
  											 "716924385",
  											 "984537612",
  							         "569482731",
  							         "142375869",
  							         "837169254",
  							         "473851926",
  							         "258796143",
  							         "691243578"]

    expect(solver.board_state).to eql expected_solution.join("\n")
  end
end