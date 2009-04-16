class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.column "lot_id", :integer, :default => 0, :null => false
      t.column "image", :string, :limit => 200, :default => "", :null => false
    end
  add_index "photos", ["lot_id"], :name => "lotid"
  end

  def self.down
    drop_table :photos
  end
end
