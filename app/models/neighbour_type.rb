# == Schema Information
# Schema version: 45
#
# Table name: neighbour_types
#
#  id           :integer(11)   not null, primary key
#  neighbour    :string(200)   default(), not null
#  has_distance :integer(11)   default(1), not null
#

class NeighbourType < ActiveRecord::Base
  has_many :neighbours
  acts_as_dropdown :text=>'neighbour'
end
