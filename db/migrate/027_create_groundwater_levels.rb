class CreateGroundwaterLevels < ActiveRecord::Migration
  def self.up
    create_table :groundwater_levels do |t|
      t.column "level", :string, :limit => 200, :default => "", :null => false
    end
  end

  def self.down
    drop_table :groundwater_levels
  end
end
