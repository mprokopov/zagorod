# == Schema Information
# Schema version: 45
#
# Table name: grounds
#
#  id     :integer(11)   not null, primary key
#  ground :string(200)   default(), not null
#

class Ground < ActiveRecord::Base
  has_many :lots
  acts_as_dropdown :text=>'ground'
end
