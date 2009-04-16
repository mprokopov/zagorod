# == Schema Information
# Schema version: 45
#
# Table name: neighbour_distances
#
#  id       :integer(11)   not null, primary key
#  distance :string(200)   default(), not null
#

class NeighbourDistance < ActiveRecord::Base
  has_many :neighbours
  acts_as_dropdown :text=>'distance'
end
