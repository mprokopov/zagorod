# == Schema Information
# Schema version: 45
#
# Table name: lots_natures
#
#  id                 :integer(11)   not null, primary key
#  lot_id             :integer(11)   default(0)
#  nature_type_id     :integer(11)   default(0)
#  nature_distance_id :integer(11)   default(0)
#

class Nature < ActiveRecord::Base
  set_table_name 'lots_natures'
  
  belongs_to :nature_type
  belongs_to :nature_distance
  belongs_to :lot
end
