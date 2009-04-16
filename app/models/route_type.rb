# == Schema Information
# Schema version: 45
#
# Table name: route_types
#
#  id    :integer(11)   not null, primary key
#  route :string(200)   default(), not null
#

class RouteType < ActiveRecord::Base
  has_many :routes
  acts_as_dropdown :text=>'route'
end
