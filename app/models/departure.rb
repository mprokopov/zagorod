# == Schema Information
# Schema version: 45
#
# Table name: departures
#
#  id        :integer(11)   not null, primary key
#  departure :string(200)   default(), not null
#  xpoint    :integer(11)   default(0), not null
#  ypoint    :integer(11)   default(0), not null
#  image     :string(150)   default(), not null
#  image2    :string(150)   default(), not null
#  title     :string(150)   default(), not null
#  name      :string(150)   default(), not null
#

class Departure < ActiveRecord::Base
  has_many :lots
  acts_as_dropdown :text=>"departure"
end
