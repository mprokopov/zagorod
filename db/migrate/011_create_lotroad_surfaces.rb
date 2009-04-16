class CreateLotroadSurfaces < ActiveRecord::Migration
  def self.up
    create_table :lotroad_surfaces do |t|
      t.column "surface", :string, :limit => 200, :default => "", :null => false
    end
  end

  def self.down
    drop_table :lotroad_surfaces
  end
end
