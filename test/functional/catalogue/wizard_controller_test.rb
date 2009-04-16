require File.dirname(__FILE__) + '/../../test_helper'
require 'catalogue/wizard_controller'

# Re-raise errors caught by the controller.
class Catalogue::WizardController; def rescue_action(e) raise e end; end

class Catalogue::WizardControllerTest < Test::Unit::TestCase
  fixtures :lots, :city_distances, :regions, :agencies, :buildings, :buildobjects, :greens, :lotroad_widths, :lotroad_distances, :lotroad_surfaces, :waters, :placements
  def setup
    @controller = Catalogue::WizardController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_step1_get_success
    get :step1
    assert_response :success
  end
  def test_should_get_step1_before_step2
    @request.session[:agency]=nil
    @request.session[:owner]=nil
    get :step2
    assert_redirected_to :action=>'step1'
    assert flash.has_key?(:notice)
  end
  def test_post_owner_to_step1_complete_and_incomplete
    ## incomplete owner
    @request.session[:agency]=nil
    @request.session[:owner]=nil
    get :step1
    assert_response :success
    @owner_count=Owner.count
    post :step1, {:owner=>{:fio=>"test fio"},:is_owner=>"Послать"}
    assert_response :success
    assert flash.has_key?(:error)
    post :step1, {
        :owner=>{
            :fio=>"test fio", 
            :phone_city=>"222333",
            :phone=>"444555", 
            :another_contact_fio=>"Ф И О человека", 
            :another_contact_phone=>"22233344", 
            :email=>"mp@it-link.com.ua",
            :is_other_contacts_allowed=>"1"
        },
        :is_owner=>"Послать"
    }
    assert_session_has :owner
    assert_redirected_to :action=>"step2"
    assert @owner_count<Owner.count ## протестим что запись таки добавилась
  end
  def test_should_step1_post_agency_complete_and_incomplete
    ## incomplete agency
    @agency_count=Agency.count
    @request.session[:agency]=nil
    @request.session[:owner]=nil
    get :step1
    assert_response :success
    post :step1, {:agency=>{:fio=>"test fio"},:is_agency=>"Послать"}
    assert flash.has_key?(:error)
    assert_session_has_no "agency" ## не произошло добавления в сессию
    assert_response :success
    post :step1, {:agency=>{:fio=>"test fio", :name=>'Лунный свет',:address=>"Васильковская", :phone1=>"222333",:phone2=>"444555",:email=>"mp@it-link.com.ua"},:is_agency=>"Послать"}
    assert_session_has :agency
    assert_redirected_to :action=>"step2"
    assert @agency_count<Agency.count ## протестим что запись таки добавилась
  end
  def test_should_redirect_from_index_to_step1
    get :index
    assert_redirected_to :action=>'step1'
  end
  def test_should_update_owner_if_back_form_step2
    @request.session[:owner]=Owner.find_by_id('1')
    get :step2
    assert_response :success
    assert_session_has :owner
    get :step1
    assert_response :success
    post :step1, {:owner=>{:fio=>"test fio", :phone_city=>"222333",:phone=>"444555", :another_contact_fio=>"Ф И О человека", :another_contact_phone=>"22233344", :email=>"mp@it-link.com.ua",:is_other_contacts_allowed=>"1"},:is_owner=>"Послать"}
    @owner=Owner.find_by_id('1')
    assert_equal @owner.fio,"test fio"
    assert_equal @owner.is_other_contacts_allowed,1
  end
  def test_should_update_agency_if_back_form_step2
    @request.session[:agency]=Agency.find_by_id('1')
    get :step2
    assert_response :success
    assert_session_has :agency
    get :step1
    assert_response :success
    post :step1, {:agency=>{:fio=>"test fio", :name=>'Лунный свет',:address=>"Васильковская", :phone1=>"222333",:phone2=>"444555",:email=>"mp@it-link.com.ua"},:is_agency=>"Послать"}
    @agency=Agency.find_by_id('1')
    assert_equal @agency.fio,"test fio"
    assert_equal @agency.name,'Лунный свет'
  end
  def test_should_add_complete_lot_post_from_step2
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []
    @request.session[:agency]=Agency.find_by_id(1)
    @lots_count=Lot.count
    assert_equal ActionMailer::Base.deliveries.length,0
    post :step2, {"lot"=>{
      :area=>"Населенный",
      :region_id=>"2",
      :square=>"20",
      :price_per_square=>"5",
      :square_for_building=>"5",
      :distance_to_city=>'3',
      :lotroad_distance_id=>"2",
      :lotroad_surface_id=>"2",
      :lotroad_width_id=>'4',
      :placement_id=>'2',
      :ground_id=>'2',
      :groundwater_level_id=>'1',
      :nearest_commerce_another=>"",
      :noise_id=>'1',
      :is_price_changeble=>"false",
      :gas_id=>'1',
      :water_id=>'2',
      :electricity_id=>'3',
      :agency_id=>'1'
    },
    :nature_type=>["2","5"],
    :nature_distance=>{"distance2"=>"1", "distance5"=>"1"},
    :route_type=>["2"],
    :route_distances=>{"distance2"=>"1"},
    :neighbour_type=>["2","5"],
    :neighbour_distance=>{"distance2"=>"1", "distance5"=>"2"},
    :build_objects=>{"id"=>"7"},
    :buildings=>["2","4"],
    :green=>["2","3"],
    :relief=>["1","2"],
    :kievpoint=>"3"
    }
    assert_redirected_to :action=>'step3'
    assert Lot.count>@lots_count # ура, добавилось
    assert flash.has_key?(:notice)
    ## TODO протестить, что мыло действительно ушло
    assert ActionMailer::Base.deliveries.length>0
  end
  def test_incomplete_post_to_add_lot_card
    @request.session[:agency]=Agency.find_by_id(1)
    post :step2, {:lot=>{"square_for_building"=>"5","square"=>"20","price_per_square"=>"5","agency_id"=>"1"}}
    assert flash.has_key?(:error)
    assert_response :success
  end
  def test_should_step3_without_lot_redirect_to_step2
      @request.session[:lot_id]=nil
      get :step3
      assert_redirected_to :action=>'step2'
  end
end
