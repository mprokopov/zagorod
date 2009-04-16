# == Schema Information
# Schema version: 45
#
# Table name: contact_requests
#
#  id         :integer(11)   not null, primary key
#  name       :string(255)   
#  phone      :string(255)   
#  email      :string(255)   
#  lot_id     :integer(11)   default(0), not null
#  created_on :datetime      
#  updated_on :datetime      
#

class ContactRequest < ActiveRecord::Base
  belongs_to :lot
  validates_presence_of :name,
                        :message=>'Укажите имя'
  validates_presence_of :phone,
                        :message=>'Укажите телефон'
  validates_presence_of :email,
                        :message=>'Укажите email'
  validates_presence_of :lot_id,
                        :message=>'Не указан номер участка'
end
