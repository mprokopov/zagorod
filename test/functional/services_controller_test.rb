require File.dirname(__FILE__) + '/../test_helper'
require 'services_controller'

# Re-raise errors caught by the controller.
class ServicesController; def rescue_action(e) raise e end; end

class ServicesControllerTest < Test::Unit::TestCase
  def setup
    @controller = ServicesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    get :index
    assert_response :success
  end
  def test_should_redirect_to_index_if_wrong_integer
    get :getcontacts, :id=>'bla-bla-bla'
    assert flash.has_key?(:notice)
    assert_redirected_to :action=>'index'
  end
  def test_should_redirect_to_index_if_no_integer
    get :getcontacts
    assert flash.has_key?(:notice)
    assert_redirected_to :action=>'index'
  end
  def test_shoud_success_if_lot_exists_and_has_owner
    post :getcontacts, :id=>'3105'
    assert_response :success
  end
  def test_should_post_contacts
    post :save, :contacts=>{
      :lot_id=>'3097',
      :name=>'Тестовый',
      :phone=>'222333444',
      :email=>'mp@it-link.com.ua'
    }
    assert_not_nil ContactRequest.find_by_name('Тестовый')
    assert_response :success
  end
  def test_should_not_save_contacts_with_error_message
    post :save, :contacts=>{
      :name=>'Тестовый',
      :email=>'mp@it-link.com.ua'
    }
    assert_nil ContactRequest.find_by_name('Тестовый')
    assert flash.has_key?(:error)
    assert_redirected_to :action=>'getcontacts'
  end
  def test_request_for_agency_lot_contacts
    post :getcontacts, :id=>'3097' ## участок с агентством
    assert flash.has_key?(:notice)
    assert_redirected_to :action=>'index'
  end
end
