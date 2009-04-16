class CreateNatures < ActiveRecord::Migration
  def self.up
    create_table "lots_natures", :force => true do |t|
      t.column "lot_id", :integer, :default => 0
      t.column "nature_type_id", :integer, :default => 0
      t.column "nature_distance_id", :integer, :default => 0
    end
    add_index :lots_natures, [:nature_type_id,:nature_distance_id],
              :index_type => :unique, :name=> 'lots_natures_index'
  end

  def self.down
    drop_table :lots_natures
  end
end
