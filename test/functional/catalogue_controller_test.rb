require File.dirname(__FILE__) + '/../test_helper'
require 'catalogue_controller'

# Re-raise errors caught by the controller.
class CatalogueController; def rescue_action(e) raise e end; end

class CatalogueControllerTest < Test::Unit::TestCase
  fixtures :lots, :buildings, :buildings_lots, :neighbour_distances, :lots_neighbours, :neighbour_types, :regions
  def setup
    @controller = CatalogueController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
  end
  def test_index_search
    ## искать по Барышевке
    region=Region.find_by_id(1)
    post :index, :search=>{:region_id=>region.id,:square=>'4'}
    assert_response :success
  end
  def test_index_filters
    get :index, {:sort_order=>'asc',:sort_key=>'region_id'}
    assert_response :success
  end
  ## тесты для карт
  def test_get_detailed_lot
    # lot 3102 существует
    get :details,"id"=>"3102"
    assert_response :success
  end
  def test_unexpected_number_of_lot
    get :details,"id"=>"310"
    assert_redirected_to :action=>'index'
  end
  def test_unexpected_symbols_in_lot
    get :details,"id"=>"asdf3102sdfa"
    assert_redirected_to :action=>'index'
  end
  def test_print_version
    get :print,"id"=>"3102"
    assert_response :success
  end
  def test_unexpected_print
    get :print, "id"=>"xcs12324"
    assert_redirected_to :action=>'index'
  end
end
