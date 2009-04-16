# == Schema Information
# Schema version: 45
#
# Table name: groundwater_levels
#
#  id    :integer(11)   not null, primary key
#  level :string(200)   default(), not null
#

class GroundwaterLevel < ActiveRecord::Base
  has_many :lots
  acts_as_dropdown :text=>'level'
end
