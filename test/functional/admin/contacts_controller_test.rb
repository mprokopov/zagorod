require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/contacts_controller'

# Re-raise errors caught by the controller.
class Admin::ContactsController; def rescue_action(e) raise e end; end

class Admin::ContactsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::ContactsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session['user']=User.find_by_id(1000001) ## валидный юзер
  end

  # Replace this with your real tests.
  def test_index_should_redirect_to_list
    get :index
    assert_redirected_to :action=>'list'
  end
  def test_list
    get :list
    assert_response :success
  end
  def test_contact_delete
    get :delete, :id=>'12'
    assert flash.has_key?(:notice)
    assert_nil ContactRequest.find_by_id('12')
  end
end
