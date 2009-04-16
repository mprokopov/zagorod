require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/owner_controller'

# Re-raise errors caught by the controller.
class Admin::OwnerController; def rescue_action(e) raise e end; end

class Admin::OwnerControllerTest < Test::Unit::TestCase
  fixtures :users
  def setup
    @controller = Admin::OwnerController.new
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
    post :edit, :owner=>{:id=>'1',:fio=>'owner',:phone_city=>'',:email=>''}
    assert_response :success
    assert flash.has_key?(:error)
    post :edit, :owner=>{:id=>'1',:fio=>'owner',:phone=>"2222333",:phone_city=>"333444",:email=>"mp@it-link.com.ua"}
    @owner=Owner.find_by_id(1)
    assert_equal @owner.fio,'owner'
    assert_redirected_to :action=>'list'
  end
  def test_destroy
    get :delete,:id=>1
    assert flash.has_key?(:notice)
    assert_nil Owner.find_by_id(1)
  end
end
