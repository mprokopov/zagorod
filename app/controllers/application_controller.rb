# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'login_system'

class ApplicationController < ActionController::Base
  include LoginSystem
  
  def collect_errors(object)
      @error_message=''
      object.errors.each{|attr, msg| @error_message+="#{msg}<br/>"}
      @errors=object.errors.collect{|attr, msg| msg}
      flash[:error]=@error_message;
  end
end
