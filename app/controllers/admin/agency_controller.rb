class Admin::AgencyController < ApplicationController
  layout 'admin'
  before_filter :login_required
  def index
    redirect_to :action=>'list'
  end
  def list
    @agencies=Agency.paginate :page=>params[:page], :order=>'id DESC'
  end
  def edit
    if request.post?
      @agency=Agency.find_by_id(params[:agency][:id])
      @agency.attributes=params[:agency]
      if @agency.save
        flash[:notice]="Данные агенства успешно сохранены"
        redirect_to :action=>'list'
      else
        flash.now[:error]="Ошибка при сохранении"
        collect_errors(@agency)
      end
    else
      @agency=Agency.find_by_id(params[:id])
    end
  end
  def delete
    @agency=Agency.find_by_id(params[:id])
    if @agency.destroy
      flash[:notice]='Агентство успешно (и безвозвратно) удалено'
    else
      collect_errors(@agency)
    end
      redirect_to :action=>'list'
  end
end
