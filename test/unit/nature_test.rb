require File.dirname(__FILE__) + '/../test_helper'

class NatureTest < Test::Unit::TestCase
  fixtures :lots_natures 
  set_fixture_class :lots_natures => Nature

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
