# == Schema Information
# Schema version: 45
#
# Table name: nature_types
#
#  id           :integer(11)   not null, primary key
#  nature       :string(200)   default(), not null
#  has_distance :integer(11)   default(1), not null
#

class NatureType < ActiveRecord::Base
  has_many :natures
end
