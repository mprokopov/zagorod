require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/catalogue_controller'

# Re-raise errors caught by the controller.
# TODO протестировать удаление, редактирование
class Admin::CatalogueController; def rescue_action(e) raise e end; end

class Admin::CatalogueControllerTest < Test::Unit::TestCase
  fixtures :users
  def setup
    @controller = Admin::CatalogueController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session['user']=User.find_by_id(1000001)
  end

  # Replace this with your real tests.
  def test_should_get_edit
      get :edit,{:id=>3096}
      assert_response :success
  end
  def test_redirect_form_index_to_list
      get :index
      assert_redirected_to :action=>'list'
  end
  def test_should_delete_valid_lot
      get :delete,{:id=>3096}
      assert flash.has_key?(:notice)
      assert_redirected_to :action=>'list'
      assert_nil Lot.find_by_id(3096)
  end
end
