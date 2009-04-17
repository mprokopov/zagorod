class Admin::OwnerController < ApplicationController
  layout 'admin'
  before_filter :login_required
  def index
    redirect_to :action=>'list'
  end
  def list
    @owners=Owner.paginate(:page=>params[:page],:order=>'id DESC')
  end
  def edit
    if request.post?
      @owner=Owner.find_by_id(params[:owner][:id])
      @owner.attributes=params[:owner]
      if @owner.save
        flash[:notice]="Данные владельца успешно сохранены"
        redirect_to :action=>'list'
      else
        flash.now[:error]="Ошибка при сохранении"
        collect_errors(@owner)
      end
    else
      @owner=Owner.find_by_id(params[:id])
    end
  end
  def delete
    @owner=Owner.find_by_id(params[:id])
    if @owner.destroy
      flash[:notice]='Владелец успешно (и безвозвратно) удален'
    else
      collect_errors(@owner)
    end
      redirect_to :action=>'list'
  end
end
