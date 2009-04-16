require File.dirname(__FILE__) + '/../test_helper'

class OwnerTest < Test::Unit::TestCase
  fixtures :owners

  def setup
    @owner=owners(:owner_mine)
  end
  def test_should_validate
    @new_owner=Owner.new({:fio=>"Максим Прокопов"})
    assert !@new_owner.save
    ## появяццо ошибки
    assert @new_owner.errors.count>0
    @new_owner.fio="Максим Прокопов"
    @new_owner.phone_city="322221"
    @new_owner.email="mp@it-link.com.ua"
    @new_owner.another_contact_phone="222333"
    @new_owner.another_contact_fio="Тестовый тестович"
    assert @new_owner.save
  end
  def test_truth
    assert_kind_of Owner, @owner
  end
end
