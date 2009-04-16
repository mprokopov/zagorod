# == Schema Information
# Schema version: 45
#
# Table name: regions
#
#  id   :integer(11)   not null, primary key
#  name :string(200)   default(), not null
#

class Region < ActiveRecord::Base
#  has_many :lots
  acts_as_dropdown :include_blank=>true,:include_blank_text=>'--любой--'
end
