class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.column "name", :string, :limit => 200, :default => "", :null => false
    end
  end

  def self.down
    drop_table :regions
  end
end
