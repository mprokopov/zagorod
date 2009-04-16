# == Schema Information
# Schema version: 45
#
# Table name: lotroad_widths
#
#  id    :integer(11)   not null, primary key
#  width :string(200)   default(), not null
#

class LotroadWidth < ActiveRecord::Base
  has_many :lots
  acts_as_dropdown :text=>'width'
end
