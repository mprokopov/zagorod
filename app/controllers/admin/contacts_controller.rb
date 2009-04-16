class Admin::ContactsController < ApplicationController
  layout 'admin'
  before_filter :login_required
  def index
    redirect_to :action=>'list'
  end
  def list
    @contacts=ContactRequest.find(:all,:order=>'created_on DESC')
  end
  def delete
    if ContactRequest.find_by_id(params[:id]).destroy
      flash[:notice]='Контакт успешно удален'
    end
    redirect_to :action=>'list'
  end
end
