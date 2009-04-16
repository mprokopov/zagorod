class ModifyPhotoAsSortable < ActiveRecord::Migration
  def self.up
    # вес photo, для сортировки по умолчанию
    add_column("photos","weight", :integer, :default=>'0')
    # выбранное изображение для показа в участках
    add_column("lots","selected_photo_id", :integer)
  end

  def self.down
    remove_column "photos","weight"
    remove_column "lots","selected_photo_id"
  end
end
