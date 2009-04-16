class CreateBuildobjects < ActiveRecord::Migration
  def self.up
    create_table :buildobjects do |t|
      t.column "name", :string, :limit => 200, :default => "", :null => false
    end

    create_table "buildobjects_lots", :id => false, :force => true do |t|
      t.column "lot_id", :integer, :default => 0, :null => false
      t.column "buildobject_id", :integer, :default => 0, :null => false
    end

  add_index "buildobjects_lots", ["lot_id", "buildobject_id"], :name => "composite"
  end

  def self.down
    drop_table :buildobjects
    drop_table :buildobjects_lots
  end
end
