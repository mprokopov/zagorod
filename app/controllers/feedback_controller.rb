class FeedbackController < ApplicationController
  def index
    @active_tab='6'
    @feedback=params[:feedback]?Feedback.new(params[:feedback]):Feedback.new
    @page = Page.find_by_url('feedback')
    if request.post? 
      if !@feedback.empty?
        Notifier::deliver_thanks(@feedback.to_h)
        render_action :post
      else
        flash[:error]="Все поля должны быть заполнены!"
      end
    end
  end
end
class Feedback
  attr :fio
  attr :email
  attr :message
  attr :subject
  def initialize(param={})
    @fio=param[:fio] if param[:fio]
    @email=param[:email] if param[:email]
    @message=param[:message] if param[:message]
    @subject=param[:subject] if param[:subject]
  end
  def empty?
    @fio.empty? || @email.empty? || @message.empty? || @subject.empty?
  end
  def to_h
    {:fio=>@fio,:email=>@email,:message=>@message,:subject=>@subject}
  end
end
