class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table "lots_routes", :force => true do |t|
      t.column "lot_id", :integer, :default => 0
      t.column "route_distance_id", :integer, :default => 0
      t.column "route_type_id", :integer, :default => 0
    end
    add_index :lots_routes, [:route_distance_id, :route_type_id], 
              :type=>:unique, :name=>'lots_routes_index'
  end

  def self.down
    drop_table :lots_routes
  end
end
