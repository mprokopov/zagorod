class CreateBuildings < ActiveRecord::Migration
  def self.up
    create_table :buildings do |t|
      t.column "building", :string, :limit => 200, :default => "", :null => false
    end

  create_table "buildings_lots", :id => false, :force => true do |t|
    t.column "lot_id", :integer, :default => 0, :null => false
    t.column "building_id", :integer, :default => 0, :null => false
  end

  add_index "buildings_lots", ["lot_id", "building_id"], :name => "ind"
  end

  def self.down
    drop_table :buildings
    drop_table :buildings_lots
  end
end
