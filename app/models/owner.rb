# == Schema Information
# Schema version: 45
#
# Table name: owners
#
#  id                        :integer(11)   not null, primary key
#  fio                       :string(200)   default()
#  phone_city                :string(200)   default()
#  phone                     :string(200)   default()
#  another_contact_fio       :string(200)   
#  another_contact_phone     :string(200)   
#  email                     :string(200)   
#  created_on                :datetime      
#  updated_on                :datetime      
#  is_other_contacts_allowed :integer(11)   default(0), not null
#  preferred_contact_type    :string(100)   
#

class Owner < ActiveRecord::Base
  validates_presence_of :fio,
                        :message=>"ФИО не должно быть пустым"
  validates_presence_of :phone_city,
                        :message=>"Основной телефон не должен быть пустым"
  acts_as_dropdown :text=>'fio'
  has_many :lots
end
