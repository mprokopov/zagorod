require File.join(File.dirname(__FILE__), 'abstract_unit')
require File.join(File.dirname(__FILE__), 'fixtures/state')

class GenericDropdownTest < Test::Unit::TestCase
  fixtures :states

  def setup
    State.acts_as_dropdown
  end

  def test_class_to_dropdown_method
    assert_equal "name", State.dropdown_text_attr
    assert_equal "id", State.dropdown_value_attr
    assert_equal [["Alabama", 1], ["Alaska", 2], ["Arizona", 3], ["California", 4], ["Colorado", 5]], State.to_dropdown
  end
end

class CustomizeDropdownTest < Test::Unit::TestCase
  fixtures :states

  def setup
    State.acts_as_dropdown
  end

  def test_class_to_dropdown_change_text
    assert_equal [["AL", 1], ["AK", 2], ["AZ", 3], ["CA", 4], ["CO", 5]], State.to_dropdown(:text => "abbreviation")
  end

  def test_class_to_dropdown_change_value
    assert_equal [["Alaska", "AK"], ["Alabama", "AL"], ["Arizona", "AZ"], ["California", "CA"], ["Colorado", "CO"]], State.to_dropdown(:value => "abbreviation")
  end

  def test_class_to_dropdown_change_order
    assert_equal [["Colorado", 5], ["California", 4], ["Arizona", 3], ["Alabama", 1], ["Alaska", 2]], State.to_dropdown(:order => "abbreviation DESC")
  end

  def test_class_to_dropdown_change_conditions
    assert_equal [["Alabama", 1], ["Alaska", 2], ["Arizona", 3], ["California", 4]], State.to_dropdown(:conditions => "id < 5")
  end

  def test_class_to_dropdown_change_all
    assert_equal [[3, "AZ"], [1, "AL"], [2, "AK"]], State.to_dropdown(:text => "id", :value => "abbreviation", :order => "abbreviation DESC", :conditions => "id < 4")
  end
end

class ArrayDropdownTest < Test::Unit::TestCase
  fixtures :states

  def test_array_to_dropdown
    states = State.find(:all, :order => "id")
    assert_equal [["Alabama", 1], ["Alaska", 2], ["Arizona", 3], ["California", 4], ["Colorado", 5]], states.to_dropdown
  end

  def test_array_to_dropdown_change_text
    states = State.find(:all, :order => "id")
    assert_equal [["AL", 1], ["AK", 2], ["AZ", 3], ["CA", 4], ["CO", 5]], states.to_dropdown("abbreviation")
  end
end

class StateOverrideTest < Test::Unit::TestCase
  fixtures :states

  def test_class_to_dropdown_change_text_at_class
    assert_equal [["AL", 1], ["AK", 2], ["AZ", 3], ["CA", 4], ["CO", 5]], StateOverride.to_dropdown
  end  
end