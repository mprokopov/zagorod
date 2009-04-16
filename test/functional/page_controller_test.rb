require File.dirname(__FILE__) + '/../test_helper'
require 'page_controller'

# Re-raise errors caught by the controller.
class PageController; def rescue_action(e) raise e end; end

class PageControllerTest < Test::Unit::TestCase
  fixtures :pages
  def setup
    @controller = PageController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_get_about_page
    get :index, {:url=>'about', :active_tab=>'3'}
    assert_response :success
    opts = {:controller => 'page', :url => 'about', :active_tab=>'3'}
    assert_generates 'about', opts
  end
end
