# == Schema Information
# Schema version: 45
#
# Table name: lotroad_surfaces
#
#  id      :integer(11)   not null, primary key
#  surface :string(200)   default(), not null
#

class LotroadSurface < ActiveRecord::Base
  has_many :lots
  acts_as_dropdown :text=>'surface'
end
