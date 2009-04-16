require File.dirname(__FILE__) + '/../test_helper'
require 'map_controller'

# Re-raise errors caught by the controller.
class MapController; def rescue_action(e) raise e end; end

class MapControllerTest < Test::Unit::TestCase
  fixtures :regions
  def setup
    @controller = MapController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_index
    get :index
    assert_response :success
    ## должен прийти флеш
    assert_tag :tag=>'object'
  end
  def test_kiev
    get :kiev
    assert_response :success
    ## тоже должен прийти флеш
    assert_tag :tag=>'object'
  end
  def test_map_data
    region=Region.find_by_id(1)
    post :index,:search=>{:region_id=>region.id,:square=>'4'}
    assert_response :success
  end
  def test_kiev_map_data
    ## получаем XML
    get :kievmapdata
    assert_response :success
  end
end
