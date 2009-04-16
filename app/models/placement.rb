# == Schema Information
# Schema version: 45
#
# Table name: placements
#
#  id        :integer(11)   not null, primary key
#  placement :string(200)   default(), not null
#

class Placement < ActiveRecord::Base
#  has_many :lots
  acts_as_dropdown :text=>'placement', :include_blank=>true,:include_blank_text=>'--не имеет значения--'
end
