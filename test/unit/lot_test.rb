require File.dirname(__FILE__) + '/../test_helper'
## TODO тесты связанных таблиц
class LotTest < Test::Unit::TestCase
  fixtures :lots
  def setup
    @my_sample=lots(:lots_001)
  end

  def test_create
    assert_equal @my_sample.noise_id,1
    assert_equal @my_sample.placement_id,6
  end
  def test_validate
    @lot=@my_sample
    @lot.area=""
    assert !@lot.save
    assert @lot.errors.count>0
  end
  def test_update
    @lot=@my_sample
    # тестирование вычисляемой полной суммы
    assert_equal @lot.price_per_square,200   
    @lot.price_per_square=125
    assert @lot.save, @lot.errors.full_messages.join("; ")
    @lot.reload
    assert_equal @lot.price_per_square,125
  end
  def test_destroy
    @lot=@my_sample
    @lot.destroy
    assert_equal Lot.find_by_id('3090'),nil
  end
  def test_should_full_price_be_calculated_after_save
    @lot=@my_sample
    @lot.price_per_square=5
    @lot.square=10
    @lot.save
    assert_equal @lot.full_price,5000
  end
end
