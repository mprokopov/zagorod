# == Schema Information
# Schema version: 45
#
# Table name: pages
#
#  id            :integer(11)   not null, primary key
#  parent_id     :integer(11)   default(0)
#  url           :string(255)   
#  text          :text          
#  is_published  :integer(4)    
#  in_top_menu   :string(0)     default()
#  has_left_menu :integer(11)   default(0)
#  title         :string(255)   
#  preview       :text          
#  keywords      :text          default(), not null
#  description   :text          default(), not null
#

class Page < ActiveRecord::Base
  acts_as_tree
end
