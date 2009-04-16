# == Schema Information
# Schema version: 45
#
# Table name: buildobjects
#
#  id   :integer(11)   not null, primary key
#  name :string(200)   default(), not null
#

class Buildobject < ActiveRecord::Base
    has_and_belongs_to_many :lots
    acts_as_dropdown
end
