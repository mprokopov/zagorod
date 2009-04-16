class CreateReliefs < ActiveRecord::Migration
  def self.up
    create_table :reliefs do |t|
      t.column "relief", :string, :limit => 200, :default => "", :null => false
    end
    create_table "lots_reliefs", :id => false, :force => true do |t|
      t.column "lot_id", :integer, :default => 0, :null => false
      t.column "relief_id", :integer, :default => 0, :null => false
    end
    add_index :lots_reliefs, [:lot_id,:relief_id], :type=>:unique, :name=>'lots_reliefs_index'
  end

  def self.down
    drop_table :reliefs
    drop_table :lots_reliefs
  end
end
