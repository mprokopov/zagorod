# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'login_system'

class ApplicationController < ActionController::Base
  include LoginSystem
  before_filter :sape_init
  
  def collect_errors(object)
      @error_message=''
      object.errors.each{|attr, msg| @error_message+="#{msg}<br/>"}
      @errors=object.errors.collect{|attr, msg| msg}
      flash[:error]=@error_message;
  end
  
  def sape_init
    @sape = Sape.from_request('bb864d84ebe5fc2bcbbfc92f276a5569', request)
  end  
end
