class Notifier < ActionMailer::Base
  def thanks( feedback )
    @charset='utf-8'
    # Email header info MUST be added here
    @recipients = ADMIN_EMAIL
    @from = "#{feedback[:fio]}<#{feedback[:email]}>"
    @subject = "[ сайт Загород: обратная связь ] #{feedback[:subject]}"
    @body['message'] = feedback[:message]
    @body['fio'] = feedback[:fio]
  end
  def newlot( lot )
    @charset='utf-8'
    @recipients = ADMIN_EMAIL
    @from = "zagorod@it-link.com.ua"
    @subject = "[ сайт Загород: новый участок ]"
    @body['lot'] = lot 
    content_type 'text/html'   #    <== note this line
  end
  def contactrequest( contact )
    @charset='utf-8'
    @recipients = ADMIN_EMAIL
    @from = "zagorod@it-link.com.ua"
    @subject = "[ сайт Загород: запрос контактов ] на участок #{contact.lot.id.to_s}"
    @body['name'] = contact.name
    @body['phone'] = contact.phone
    @body['email'] = contact.email
    @body['lot'] = contact.lot
    content_type 'text/html'   #    <== note this line
  end
end
