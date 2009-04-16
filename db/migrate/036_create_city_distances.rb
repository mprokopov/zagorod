class CreateCityDistances < ActiveRecord::Migration
  def self.up
    create_table :city_distances do |t|
    t.column "distance", :string, :limit => 200, :default => "", :null => false
    t.column "min_distance", :integer, :default => 0, :null => false
    t.column "max_distance", :integer, :default => 0, :null => false
    end
  end

  def self.down
    drop_table :city_distances
  end
end
