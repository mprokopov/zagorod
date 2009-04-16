require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/agency_controller'

# Re-raise errors caught by the controller.
class Admin::AgencyController; def rescue_action(e) raise e end; end

class Admin::AgencyControllerTest < Test::Unit::TestCase
  fixtures :users
  def setup
    @controller = Admin::AgencyController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session['user']=User.find_by_id(1000001)
  end

  # Replace this with your real tests.
  def test_should_index_redirect_to_list
    get :index
    assert_redirected_to :action=>'list'
  end
  def test_should_get_list
    get :list
    assert_response :success
  end
  def test_edit_action
    post :edit, :agency=>{:id=>'1',:name=>'agency',:phone1=>'',:email=>''}
    assert_response :success
    assert flash.has_key?(:error)
    post :edit, :agency=>{:id=>'1',:name=>'agency',:phone1=>"2222333",:phone2=>"333444",:email=>"mp@it-link.com.ua"}
    @agency=Agency.find_by_id(1)
    assert_equal @agency.name,'agency'
    assert_redirected_to :action=>'list'
  end
  def test_destroy
    get :delete,:id=>1
    assert flash.has_key?(:notice)
    assert_nil Agency.find_by_id(1)
  end
end
