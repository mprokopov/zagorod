# == Schema Information
# Schema version: 45
#
# Table name: squares
#
#  id         :integer(11)   not null, primary key
#  square     :string(100)   default(), not null
#  min_square :float         default(0.0), not null
#  max_square :float         default(0.0), not null
#

class Square < ActiveRecord::Base
  acts_as_dropdown :text=>"square", :include_blank=>true,:include_blank_text=>'--любая--'
end
