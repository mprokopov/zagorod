class HomeController < ApplicationController
  def index
    @page_title='Главная'
    redirect_to :controller=>'catalogue', :action=>'index'
  end
end
