# == Schema Information
# Schema version: 45
#
# Table name: noise_sources
#
#  id     :integer(11)   not null, primary key
#  source :string(150)   default(), not null
#

class NoiseSource < ActiveRecord::Base
    has_and_belongs_to_many :lots
end
