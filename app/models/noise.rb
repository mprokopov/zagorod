# == Schema Information
# Schema version: 45
#
# Table name: noises
#
#  id    :integer(11)   not null, primary key
#  noise :string(150)   default(), not null
#

class Noise < ActiveRecord::Base
  has_many :lots
  acts_as_dropdown :text=>'noise',:include_blank=>true,:include_blank_text=>'-- не выбран --'
end
