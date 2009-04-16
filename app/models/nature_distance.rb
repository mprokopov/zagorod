# == Schema Information
# Schema version: 45
#
# Table name: nature_distances
#
#  id       :integer(11)   not null, primary key
#  distance :string(200)   default(), not null
#

class NatureDistance < ActiveRecord::Base
  has_many :natures
  acts_as_dropdown :text=>'distance'
end
