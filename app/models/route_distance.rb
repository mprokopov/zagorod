# == Schema Information
# Schema version: 45
#
# Table name: route_distances
#
#  id       :integer(11)   not null, primary key
#  distance :string(150)   default(), not null
#

class RouteDistance < ActiveRecord::Base
  has_many :routes
  acts_as_dropdown :text=>'distance'
end
