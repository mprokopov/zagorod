require File.dirname(__FILE__) + '/../test_helper'

class AgencyTest < Test::Unit::TestCase
  fixtures :agencies

  def setup
    @agency=agencies(:agency_mine)
  end
  def test_kind_of
    assert_kind_of Agency, @agency
  end
  def test_should_validate
    @new_agency=Agency.new
    @new_agency.fio="Test"
    @new_agency.name="test"
    assert !@new_agency.save
    assert @new_agency.errors.count>0
    @new_agency.address="test3"
    @new_agency.phone1="222333"
    @new_agency.phone2="333222"
    @new_agency.email="nexus@mp.kiev.ua"
    assert @new_agency.save
  end
end
