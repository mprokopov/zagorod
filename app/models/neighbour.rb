# == Schema Information
# Schema version: 45
#
# Table name: lots_neighbours
#
#  id                    :integer(11)   not null, primary key
#  lot_id                :integer(11)   default(0)
#  neighbour_distance_id :integer(11)   default(0)
#  neighbour_type_id     :integer(11)   default(0)
#

class Neighbour < ActiveRecord::Base
  set_table_name 'lots_neighbours'
 
  belongs_to :neighbour_type
  belongs_to :neighbour_distance
  belongs_to :lot
end
