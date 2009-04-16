# == Schema Information
# Schema version: 45
#
# Table name: buildings
#
#  id       :integer(11)   not null, primary key
#  building :string(200)   default(), not null
#

class Building < ActiveRecord::Base
  has_and_belongs_to_many :lots
end
