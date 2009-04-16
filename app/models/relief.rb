# == Schema Information
# Schema version: 45
#
# Table name: reliefs
#
#  id     :integer(11)   not null, primary key
#  relief :string(200)   default(), not null
#

class Relief < ActiveRecord::Base
    has_and_belongs_to_many :lots
end
