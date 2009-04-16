# == Schema Information
# Schema version: 45
#
# Table name: waters
#
#  id     :integer(11)   not null, primary key
#  object :string(200)   default(), not null
#

class Water < ActiveRecord::Base
  has_many :lots
  acts_as_dropdown :text=>'object',:include_blank=>true,:include_blank_text=>'-- не выбрано --'
end
