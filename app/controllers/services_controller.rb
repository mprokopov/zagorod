class ServicesController < ApplicationController
  ## контент в админзоне
  def index
    @active_tab='4'
    @page=Page.find_by_url('services')
  end
  ## запрос на контакты (как параметр - валидный номер
  def getcontacts
    @active_tab='4'
    @lot=Lot.find_by_id(params[:id]) if params[:id].to_i.is_a?(Integer)
    if !@lot
      flash[:notice]="Укажите, пожалуйста, существующий номер участка"
      redirect_to :action=>'index'
    else
      if @lot.owner
        @page_title="Запрос контактов на участок #{@lot.id.to_s}"
      elsif @lot.agency
        flash[:notice]="Внимание, участок ##{"%05d" % @lot.id} добавил посредник, это значит, что контакты посредника доступны бесплатно!<br/>Вы можете посмотреть контакты на <a href='/catalogue/details/#{@lot.id.to_s}'>детальной карточке участка</a>."
        redirect_to :action=>'index'
      end
    end
  end
  ## отправка запроса администратору
  def save
    @active_tab='4'
    if params[:contacts]
      newcontact = ContactRequest.new(params[:contacts])
      if newcontact.save  ## проверка на валидацию
        Notifier::deliver_contactrequest( newcontact )
      else
        collect_errors( newcontact )
        redirect_to :action=>'getcontacts', :id=>params[:contacts][:id]
      end
    end
  end
end
