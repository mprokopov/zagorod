# == Schema Information
# Schema version: 45
#
# Table name: lotroad_distances
#
#  id       :integer(11)   not null, primary key
#  distance :string(150)   default(), not null
#

class LotroadDistance < ActiveRecord::Base
  has_many :lots
  acts_as_dropdown :text=>'distance'
end
