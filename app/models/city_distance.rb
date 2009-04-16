# == Schema Information
# Schema version: 45
#
# Table name: city_distances
#
#  id           :integer(11)   not null, primary key
#  distance     :string(200)   default(), not null
#  min_distance :integer(11)   default(0), not null
#  max_distance :integer(11)   default(0), not null
#

class CityDistance < ActiveRecord::Base
  acts_as_dropdown :text=>'distance',:include_blank=>true,:include_blank_text=>'--любое--'
end
