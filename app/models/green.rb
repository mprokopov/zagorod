# == Schema Information
# Schema version: 45
#
# Table name: greens
#
#  id    :integer(11)   not null, primary key
#  green :string(200)   default(), not null
#

class Green < ActiveRecord::Base
  has_and_belongs_to_many :lots
end
