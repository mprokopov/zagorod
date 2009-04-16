class CreateGreens < ActiveRecord::Migration
  def self.up
    create_table :greens do |t|
      t.column "green", :string, :limit => 200, :default => "", :null => false
    end

  create_table "greens_lots", :id => false, :force => true do |t|
    t.column "lot_id", :integer, :default => 0, :null => false
    t.column "green_id", :integer, :default => 0, :null => false
  end

  add_index "greens_lots", ["lot_id", "green_id"], :name => "lot_green"
  end

  def self.down
    drop_table :greens
    drop_table :greens_lots
  end
end
