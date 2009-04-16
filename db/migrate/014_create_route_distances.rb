class CreateRouteDistances < ActiveRecord::Migration
  def self.up
    create_table :route_distances do |t|
      t.column "distance", :string, :limit => 150, :default => "", :null => false
    end
  end

  def self.down
    drop_table :route_distances
  end
end
