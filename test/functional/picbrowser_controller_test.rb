require File.dirname(__FILE__) + '/../test_helper'
require 'picbrowser_controller'

# Re-raise errors caught by the controller.
class PicbrowserController; def rescue_action(e) raise e end; end

class PicbrowserControllerTest < Test::Unit::TestCase
  def setup
    @controller = PicbrowserController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @test_dir="_mytest_dir_123"
    @request.session[:current_directory]=nil
  end

  def test_get_index_picture_list
    get :index
    assert_response :success
    assert_not_nil assigns(:image_collection)
  end
  def test_get_javascript_image_array
    get :generate_image_list_javascript
    assert_response :success
  end
  def test_make_new_directory
    get :index
    @current_dir=@request.session[:current_directory]
    Dir.delete "#{@current_dir}./#{@test_dir}" if  FileTest.exists?("#{@current_dir}./#{@test_dir}")
    post :makedir, {:new_directory=>@test_dir}
    assert_equal @request.session[:current_directory],@current_dir+"#{@test_dir}/"
    assert_redirected_to :action=>'index'
    post :makedir, {:current_directory=>'./',:new_directory=>@test_dir}
    assert_equal flash[:notice],"Директория уже существует"
  end
  def test_successfull_and_unsuccessfull_upload_to_test_dir
    post :index,{:current_directory=>"#{@test_dir}/"}
    assert_equal @request.session[:current_directory],"#{@test_dir}/"
    assert_response :success
    post :upload, {:picture => ActionController::TestUploadedFile.new(Test::Unit::TestCase.fixture_path + '/files/map.gif', 'image/gif')}
    ## test thumbnail + test image
    assert_redirected_to :action=>'index'
    @current_dir=@request.session[:current_directory]
    assert File.exists?("public/images/#{@current_dir}/map.gif")
    assert File.exists?("public/images/#{@current_dir}/thumbnails/map.gif")
    assert_equal flash[:notice],'Файл успешно загружен'
    get :details, {:filename=>'map.gif'}
    assert_not_nil assigns(:img)
    post :upload
    assert_redirected_to :action=>'index'
    assert_equal flash[:notice],'Укажите файл'
  end
  def test_delete_file
    get :index, {:current_directory=>"#{@test_dir}/"}
    @current_dir=@request.session[:current_directory]
    assert_equal @current_dir,"#{@test_dir}/"
    assert File.exists?("public/images/#{@current_dir}map.gif")
    assert File.exists?("public/images/#{@current_dir}thumbnails/map.gif")
    get :delete, {:filename=>'map.gif'}
    assert !File.exists?("public/images/#{@current_dir}map.gif")
    assert !File.exists?("public/images/#{@current_dir}thumbnails/map.gif")
  end
end
