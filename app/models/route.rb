# == Schema Information
# Schema version: 45
#
# Table name: lots_routes
#
#  id                :integer(11)   not null, primary key
#  lot_id            :integer(11)   default(0)
#  route_distance_id :integer(11)   default(0)
#  route_type_id     :integer(11)   default(0)
#

class Route < ActiveRecord::Base
  set_table_name 'lots_routes'
  
  belongs_to :route_type
  belongs_to :route_distance
  belongs_to :lot
end
