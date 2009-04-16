class CreateLots < ActiveRecord::Migration
  def self.up
    create_table :lots do |t|
      t.column "area", :string, :limit => 200, :default => "", :null => false
      t.column "square", :float, :default => 0.0, :null => false
      t.column "price_per_square", :integer, :default => 0, :null => false
      t.column "is_price_changeble", :boolean, :default => false, :null => false
      t.column "distance_to_city", :float, :default => 0.0, :null => false
      t.column "departure_id", :integer, :default => 0, :null => false
      t.column "lotroad_distance_id", :integer, :default => 0, :null => false
      t.column "lotroad_surface_id", :integer, :default => 0, :null => false
      t.column "lotroad_width_id", :integer, :default => 0, :null => false
      t.column "is_another_routes", :boolean, :default => false, :null => false
      t.column "gas_id", :integer, :default => 0, :null => false
      t.column "electricity_id", :integer, :default => 0, :null => false
      t.column "water_id", :integer, :default => 0, :null => false
      t.column "nearest_shop_distance", :float, :default => 0.0 
      t.column "nearest_kiosk_distance", :float, :default => 0.0
      t.column "nearest_commerce_another", :text, :default => ""
      t.column "placement_id", :integer, :default => 0, :null => false
      t.column "placement_another", :text, :default => "", :null => false
      t.column "nature_types_another", :text, :default => "", :null => false
      t.column "lot_length", :float, :default => 0.0, :null => false
      t.column "lot_width", :float, :default => 0.0, :null => false
      t.column "lot_shape", :string, :limit => 200, :default => "", :null => false
      t.column "ground_id", :integer, :default => 0, :null => false
      t.column "ground_another", :text, :default => "", :null => false
      t.column "building_another", :text, :default => "", :null => false
      t.column "green_another", :string, :limit=> 200, :null => false
      t.column "relief_another", :text, :default => "", :null => false
      t.column "groundwater_level_id", :integer, :default => 0, :null => false
      t.column "noise_source_another", :text, :default => "", :null => false
      t.column "buildobjects_another", :text, :default => "", :null => false
      t.column "extra_info", :text, :default => "", :null => false
      t.column "region_id", :integer, :default => 0, :null => false
      t.column "square_for_building", :float, :default => 0.0, :null => false
      t.column "noise_id", :integer, :default => 0, :null => false
      t.column "full_price", :integer, :default => 0, :null => false
      t.column "lotroad_surface_another", :string, :limit => 200, :default => "", :null => false
      t.column "nearest_shop_distance_another", :string, :limit => 200, :default => "", :null => false
      t.column "is_reviewed", :boolean, :default => false, :null => false
      t.column "point_x", :integer, :default => 0, :null => false
      t.column "point_y", :integer, :default => 0, :null => false
      t.column "agency_id", :integer, :null => true
      t.column "owner_id", :integer, :null => true
      t.column "created_on", :timestamp
      t.column "updated_on", :timestamp
    end

    add_index "lots", ["area"], :name => "areaindex"
    add_index "lots", ["square"], :name => "squareindex"
    add_index "lots", ["departure_id"], :name => "departure_id"
    add_index "lots", ["lotroad_distance_id"], :name => "distance_to_road"
    add_index "lots", ["lotroad_surface_id"], :name => "surface_to_road"
    add_index "lots", ["lotroad_width_id"], :name => "surface_width"
    add_index "lots", ["gas_id"], :name => "gas"
    add_index "lots", ["electricity_id"], :name => "electricity"
    add_index "lots", ["water_id"], :name => "water"
    add_index "lots", ["placement_id"], :name => "placement"
    add_index "lots", ["ground_id"], :name => "ground"
    add_index "lots", ["groundwater_level_id"], :name => "groundwater"
    add_index "lots", ["region_id"], :name => "region_id"
    add_index "lots", ["noise_id"], :name => "noise_id"
    add_index "lots", ["full_price"], :name => "full_price"
    add_index "lots", ["owner_id"], :name => "owner_id"
    add_index "lots", ["agency_id"], :name => "agency_id"
    ## стартовое значение для автоинкремента
    execute 'alter table lots auto_increment=3000';
  end

  def self.down
    drop_table :lots
  end
end
