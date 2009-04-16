# == Schema Information
# Schema version: 45
#
# Table name: full_prices
#
#  id        :integer(11)   not null, primary key
#  price     :string(200)   default(), not null
#  min_price :float         default(0.0), not null
#  max_price :float         default(0.0), not null
#

class FullPrice < ActiveRecord::Base
  acts_as_dropdown :text=>'price',:include_blank=>true,:include_blank_text=>'--любая--'
end
