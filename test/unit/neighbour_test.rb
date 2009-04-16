require File.dirname(__FILE__) + '/../test_helper'

class NeighbourTest < Test::Unit::TestCase
  fixtures :lots_neighbours
  set_fixture_class :lots_neighbours=>Neighbour
  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
