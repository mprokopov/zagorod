# == Schema Information
# Schema version: 45
#
# Table name: gas
#
#  id       :integer(11)   not null, primary key
#  distance :string(200)   default(), not null
#

class Gas < ActiveRecord::Base
  has_many :lots
  acts_as_dropdown :text=>'distance',:include_blank=>true,:include_blank_text=>'-- не выбран --'
end
