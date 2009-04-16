# == Schema Information
# Schema version: 45
#
# Table name: agencies
#
#  id         :integer(11)   not null, primary key
#  fio        :string(200)   default()
#  name       :string(200)   default()
#  address    :string(200)   default()
#  phone1     :string(100)   default()
#  phone2     :string(100)   default()
#  email      :string(200)   
#  created_on :datetime      
#  updated_on :datetime      
#

class Agency < ActiveRecord::Base
  validates_presence_of :fio,
                        :message=>"ФИО не должно быть пустым"
  validates_presence_of :phone1,
                        :message=>"телефон не должен быть пустым"
  has_many :lots
  acts_as_dropdown :include_blank=>true,:include_blank_text=>'выберите хозяина'
end
