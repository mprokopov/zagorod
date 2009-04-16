# == Schema Information
# Schema version: 45
#
# Table name: photos
#
#  id     :integer(11)   not null, primary key
#  lot_id :integer(11)   default(0), not null
#  image  :string(200)   default(), not null
#

class Photo < ActiveRecord::Base
  belongs_to :lot
  file_column :image, :magick=>{
    :versions=>{"thumb"=>"174x121","preview"=>"121x88","large"=>"800x600"}
  }
  #validates_image_size  :image, :min => "800x600"
end
